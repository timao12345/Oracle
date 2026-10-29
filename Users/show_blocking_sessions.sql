rem -------------------------------------------------------------------------
rem   Show users waiting for a lock, the locker and the
rem   SQL-Command they are waiting for a lock
rem   osuser, schema and PIDs are shown
rem -----------------------------------------------------------------------
rem
--
SET PAGES 24 LINES 100 FEED ON ECHO OFF TERMOUT ON HEAD ON
COLUMN OS_LOCKER FORMAT A15 TRUNC
COLUMN OS_WAITER FORMAT A15 TRUNC
COLUMN LOCKER_SCHEMA FORMAT A15 TRUNC
COLUMN WAITER_SCHEMA FORMAT A15 TRUNC
COLUMN WAITER_PID FORMAT A10
COLUMN LOCKER_PID FORMAT A10
COLUMN SQL_TEXT_WAITER FORMAT A100 WRAP
COLUMN DATABASE NOPRINT NEW_VALUE DATABASE
COLUMN DATUM_ZEIT NOPRINT NEW_VALUE DATUM_ZEIT
SET TERMOUT OFF ECHO OFF FEED OFF
SET TERMOUT ON
TTITLE CENTER 'Current Lock-Waits' SKIP 2
--
    select  /*+ ordered
            no_merge(L_WAITER)
            no_merge(L_LOCKER) use_hash(L_LOCKER)
            no_merge(S_WAITER) use_hash(S_WAITER)
            no_merge(S_LOCKER) use_hash(S_LOCKER)
            use_nl(O)
            use_nl(U)
        */
            /* first the table-level locks (TM) and mixed TM/TX TX/TM */
        S_LOCKER.OSUSER OS_LOCKER,
        S_LOCKER.USERNAME LOCKER_SCHEMA,
        S_LOCKER.PROCESS LOCKER_PID,
        S_WAITER.OSUSER OS_WAITER,
        S_WAITER.USERNAME WAITER_SCHEMA,
        S_WAITER.PROCESS WAITER_PID,
        'Table lock (TM): '||U.NAME||'.'||O.NAME||
             ' - Mode held: '||
                     decode(L_LOCKER.LMODE,
                        0, 'None',           /* same as Monitor */
                        1, 'Null',           /* N */
                        2, 'Row-S (SS)',     /* L */
                        3, 'Row-X (SX)',     /* R */
                        4, 'Share',          /* S */
                        5, 'S/Row-X (SSX)',  /* C */
                        6, 'Exclusive',      /* X */
                        '???: '||to_char(L_LOCKER.LMODE))||
                     ' / Mode requested: '||
                     decode(L_WAITER.REQUEST,
                        0, 'None',           /* same as Monitor */
                        1, 'Null',           /* N */
                        2, 'Row-S (SS)',     /* L */
                        3, 'Row-X (SX)',     /* R */
                        4, 'Share',          /* S */
                        5, 'S/Row-X (SSX)',  /* C */
                        6, 'Exclusive',      /* X */
                        '???: '||to_char(L_WAITER.REQUEST))
                                            SQL_TEXT_WAITER
    from
        V$LOCK L_WAITER,
        V$LOCK L_LOCKER,
        V$SESSION S_WAITER,
        V$SESSION S_LOCKER,
        OBJ$ O,
        USER$ U
        where   S_WAITER.SID = L_WAITER.SID
        and     L_WAITER.TYPE IN ('TM')
        and     S_LOCKER.sid = L_LOCKER.sid
        and     L_LOCKER.ID1 = L_WAITER.ID1
        and     L_WAITER.REQUEST > 0
        and     L_LOCKER.LMODE > 0
        and     L_WAITER.ADDR != L_LOCKER.ADDR
    and     L_WAITER.ID1 = O.OBJ#
    and     U.USER# = O.OWNER#
    union
    select  /*+ ordered
            no_merge(L_WAITER)
            no_merge(L_LOCKER) use_hash(L_LOCKER)
            no_merge(S_WAITER) use_hash(S_WAITER)
            no_merge(S_LOCKER) use_hash(S_LOCKER)
            no_merge(L1_WAITER) use_hash(L1_WAITER)
            no_merge(O) use_hash(O)
            */
            /* now the (usual) row-locks TX */
        S_LOCKER.OSUSER OS_LOCKER,
        S_LOCKER.USERNAME LOCKER_SCHEMA,
        S_LOCKER.PROCESS LOCK_PID,
        S_WAITER.OSUSER OS_WAITER,
        S_WAITER.USERNAME WAITER_SCHEMA,
        S_WAITER.PROCESS WAITER_PID,
        'TX: '||O.SQL_TEXT SQL_TEXT_WAITER
    from
                V$LOCK L_WAITER,
                V$LOCK L_LOCKER,
                V$SESSION S_WAITER,
                V$SESSION S_LOCKER,
                V$_LOCK1 L1_WAITER,
                V$OPEN_CURSOR O
    where   S_WAITER.SID = L_WAITER.SID
    and     L_WAITER.TYPE IN ('TX')
        and     S_LOCKER.sid = L_LOCKER.sid
        and     L_LOCKER.ID1 = L_WAITER.ID1
        and     L_WAITER.REQUEST > 0
        and     L_LOCKER.LMODE > 0
        and     L_WAITER.ADDR != L_LOCKER.ADDR
        and     L1_WAITER.LADDR = L_WAITER.ADDR
        and     L1_WAITER.KADDR = L_WAITER.KADDR
        and     L1_WAITER.SADDR = O.SADDR
        and     O.HASH_VALUE = S_WAITER.SQL_HASH_VALUE
/
TTITLE OFF
    COLUMN OS_LOCKER CLEAR
    COLUMN OS_WAITER CLEAR
    COLUMN LOCKER_SCHEMA CLEAR
    COLUMN WAITER_SCHEMA CLEAR
    COLUMN WAITER_PID CLEAR
    COLUMN LOCKER_PID CLEAR
    COLUMN SQL_TEXT_WAITER CLEAR
    COLUMN DATABASE CLEAR
    COLUMN DATUM_ZEIT CLEAR

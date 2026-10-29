SELECT   inst_id pro,  DECODE (request, 0, 'Holder: ', 'Waiter: ') || SID sess,
         id1,
         id2,
         lmode,
         DECODE (lmode,
                 0, 'None',
                 1, 'Null',
                 2, 'Row Share',
                 3, 'Row Exlusive',
                 4, 'Share',
                 5, 'Sh/Row Exlusive',
                 6, 'Exclusive'
                ) dslmode,
         request,
         DECODE (request,
                 0, 'None',
                 1, 'Null',
                 2, 'Row Share',
                 3, 'Row Exlusive',
                 4, 'Share',
                 5, 'Sh/Row Exlusive',
                 6, 'Exclusive'
                ) dsrequest,
         TYPE
    FROM gv$lock
   WHERE (id1, id2, TYPE) IN (SELECT id1,
                                     id2,
                                     TYPE
                                FROM gv$lock a
                               WHERE a.request > 0)
ORDER BY id1,
         request

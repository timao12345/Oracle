declare
      v_unformatted_blocks number;
      v_unformatted_bytes number;
      v_fs1_blocks number;
      v_fs1_bytes number;
      v_fs2_blocks number;
      v_fs2_bytes number;
      v_fs3_blocks number;
      v_fs3_bytes number;
      v_fs4_blocks number;
      v_fs4_bytes number;
      v_full_blocks number;
      v_full_bytes number;
  begin
    dbms_space.space_usage ('CTXSYS', 'DR$WAITING', 'TABLE', v_unformatted_blocks,
    v_unformatted_bytes, v_fs1_blocks, v_fs1_bytes, v_fs2_blocks, v_fs2_bytes,
    v_fs3_blocks, v_fs3_bytes, v_fs4_blocks, v_fs4_bytes, v_full_blocks, v_full_bytes);
    dbms_output.put_line('Unformatted Blocks = '||v_unformatted_blocks);
    dbms_output.put_line('FS1 Blocks - ( <    25%) livres      = '||v_fs1_blocks);
    dbms_output.put_line('FS2 Blocks - (25% a 50%) livres      = '||v_fs2_blocks);
    dbms_output.put_line('FS3 Blocks - (50% a 75%) livres      = '||v_fs3_blocks);
    dbms_output.put_line('FS4 Blocks - ( >    75%) livres      = '||v_fs4_blocks);
    dbms_output.put_line('Full Blocks       = '||v_full_blocks);
end;

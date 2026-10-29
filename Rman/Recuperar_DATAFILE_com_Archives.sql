alter database datafile '<G:\DATAFILE_X>' offline drop;

alter database create datafile '<G:\DATAFILE_X>' as '<G:\DATAFILE_X>';

recover datafile Y;

alter database datafile '<G:\DATAFILE_X>' online;

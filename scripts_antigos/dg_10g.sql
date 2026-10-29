-- Verifica sincronismo do stadby no 10g

SELECT scn_to_timestamp(current_scn) 
FROM v$database;

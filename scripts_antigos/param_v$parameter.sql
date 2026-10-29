/*

ISSES_MODIFIABLE -- Indica se o parâmetro pode ser alterado com ALTER SESSION (TRUE) ou não (FALSO)

ISSYS_MODIFIABLE -- Indica se o parâmetro pode ser alterado com o ALTER SYSTEM e quando a alteração entrará em vigor:
IMMEDIATE - Parâmetro pode ser alterado com ALTER SYSTEM Independentemente do tipo de arquivo de parâmetro usado para iniciar a instância. A alteração tem efeito imediato.
DEFERRED - Parâmetro pode ser alterado com ALTER SYSTEM Independentemente do tipo de arquivo de parâmetro usado para iniciar a instância. mas terá efeito somente após o banco de dados ser re-inicializado.
FALSE - Se-deve baixar o banco para alteração do parâmetro. 

*/

-- Verifica um determinado parametro
SET LINES 200 PAGES 300
COL VALUE FOR A15
COL NAME FOR A40
COL ISSES_MODIFIABLE FOR A15 HEADING 'ISSES|MODIFIABLE'
COL ISSYS_MODIFIABLE FOR A15 HEADING 'ISSYS|MODIFIABLE'


UNDEF PARAM
SELECT 
	NUM, 
	NAME, 
	TYPE, 
	VALUE, 
	ISDEFAULT, 
	ISSES_MODIFIABLE, 
	ISSYS_MODIFIABLE, 
	ISINSTANCE_MODIFIABLE 
FROM V$PARAMETER
WHERE NAME='&&PARAM';
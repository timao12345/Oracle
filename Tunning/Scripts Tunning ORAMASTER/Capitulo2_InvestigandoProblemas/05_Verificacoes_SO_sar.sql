*************************************************
-- Utilitario sar (system activity report)
--     	permite ver estatisticas de monitoramento em tempo real e HISTORICAS (amostras com intervalos de 10 min)
-- 		escreve dados historicos por dia em "/var/log/sa/saXX" (XX corresponde ao dia do mes)
--		necessario ter pacote sysstat instalado
-- 		mantem historico padrao de 28 dias, mas esse valor pode ser alterado na var HISTORY do arquivo "/etc/sysconfig/sysstat"
*************************************************

-- Ver uso de cpu do dia atual
   sar 
 
-- Ver uso de cpu com refresh de 1s por 10x:
    sar 1 10

-- Ver historico de uso de cpu no dia 10 do mes vigente :
    sar -f /var/log/sa/sa10
    
-- Ver uso de memoria com refresh de 1s por 5x:
    sar -r 1 5

-- Ver historico de uso de memoria no dia 20 do mes vigente (veja se existe mesmo historico desse dia)
    sar -r -f /var/log/sa/sa20
    
-- Ver uso de swap com refresh de 1s por 20x:
    sar -W 1 20

-- Ver historico de uso de swap no dia 25 do mes vigente (veja se existe mesmo historico desse dia)
    sar -W -f /var/log/sa/sa25
        
-- Ver historico de i/o no dia 25 do mes vigente (veja se existe mesmo historico desse dia)
    sar -b -f /var/log/sa/sa06
		
			
		
Ver mais exemplos:
    http://www.thegeekstuff.com/2011/03/sar-examples/

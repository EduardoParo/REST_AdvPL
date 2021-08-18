#INCLUDE "PROTHEUS.CH"
#include "RESTFUL.ch"
#include "FILEIO.CH"
#INCLUDE "TOTVS.CH"

#Include "TOTVS.ch"
#include 'protheus.ch'
#include 'parmtype.ch'
#include "RwMake.ch"

/*/{Protheus.doc} --------------------------*
| @Treinamento - REST                       |
| @Aula:  API_SIMPLES                       |            
| @data : 17/08/2021                        |            
| @Autor: Eduardo Paro de Simoni            |        
--------------------------------------------*/
/*============================================================
POST
=============================================================*/
Function U_zPoPI()
  local   cUrl          := 'https://suaApi.com'
  local   cRest         := Nil
  local   aHeader       := {}
  Local   cHeadRet      := ""
  local   cBody         := ""
  local   jResponse
  local   nStatus         := 0
  local   cErro         := ""
  local cArq           := "/spool/informe0201000610.pdf"
  local nTimeOut        := 120

  RpcSetEnv("99","01","Administrador","")
  
  //MONTAGEM DO HEADER
  aadd(aHeader,'Authorization: Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJzY29wZSI6WyJvcGVuaWQiXSwibGFuZ3VhZ2UiOiJwdCIsImV4cCI6MTYyMDEzNjAwNCwiYXV0aG9yaXRpZXMiOlsidGVuYW50fjQ3Il0sImp0aSI6ImM1MWJjMTE1LTIyYzctNDcyMC1hM2UxLWEyZjE0ODdhNmUwNCIsImNsaWVudF9pZCI6ImZvcnRrbm94In0.CPhsqcJyGPl3UOdTeJOnhn-zgf0Vno_f4ZnkPJw8ljB81M6S6yjHrUQCm0DE6p1MMyLPkyGY3kd78G2SZXHZ2aH9ly4swsfASWGqsvp86TXsKIUdfqdttntEaf96AWzDi0mBJKRM-KRaHecU8COo_bS6SkNddTxrYFUQXtHRnMDeAXcSiA88lgXNdKzmcv2QuWc2EtOg9HCV_6hRnlEMw3r8C5MJcxhjLh6zhhIQ10ocgY1EXqDJHcpDGKwLBICnIw_qTAjIbSGMHJTEDZfKD5WEHUe45bzv9G37-3YpKQBjtY0QtO_FqzXcsbFkt_hoJAltQe-UylzrCr8NvU64Hw')
  aadd(aHeader,"Content-Type: multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW")
  aadd(aHeader,'User-Agent: Mozilla/4.0 (compatible; Protheus '+GetBuild()+')')


  //MONTAGEM DO BODY
  cBody+= 'Content-Disposition: form-data; name="attachment"; filename="/spool/informe0201000610.pdf";' + CRLF 
  cBody+= 'Content-Type: application/pdf;' + CRLF  + CRLF 

  cBody+= 'Content-Disposition: form-data; name="noticeJson"' + CRLF+ CRLF
  cBody+= '{"startDate": "25022021080000" , "finishDate": "31122037080000" , "name": "Informe Rendimentos","noticeCollectorId": 1,"noticeShowId": 3,"noticeStatusId": 1,"noticeTypeId": 2,"persons": [ 148177],"personsExternalIds": [ "0201000610" ],"text": " Informe de Rendimentos e declaracao de IRPF 2021   Quem precisa declarar o imposto? * Os que receberam rendimentos tributaveis acima de R$28559.70 durante o ano de 2020 como salarios honorarios, ferias, comissoes, pro-labore, receita com aluguel de imoveis, pensoes, entre outros.  * Todos que receberam rendimentos isentos, nao tributaveis ou tributados exclusivamente na fonte superior a R$40.000,00 durante o ano de 2020, como por exemplo: alimentacao, transporte e uniformes fornecidos pela empresa de forma gratuita, reembolso de viagens em geral, salario-familia, entre outros.  * Quem recebeu em qualquer mes, dinheiro por conta de alienacao de bens e direitos  em que o IR incida . ou entao realizaram operacao em bolsas de valores, mercadorias, futuro ou semelhantes; * Quem teve ate 31.12.2020 bens ou direitos no valor total superior a 300 mil, somando todos os bens; * Todos que venderam imoveis residenciais e obtiveram ganho na operacao, mesmo que tenha comprado outro imovel em um prazo de 180 dias e usaram da regra de isencao do imposto de renda. Quem nao precisa entregar a declaracao do imposto do IRPF atualmente?  * Para nao precisar entregar a declaracao do Imposto de Renda de Pessoa Fisica, e necessario que o contribuinte se encaixe em algum dos seguintes requisitos: * Possua rendimento mensal inferior ao valor de R$1.999,18; * Seja proprietario de bens cujo valor total da somatoria seja inferior a R$300.000,00; * Seja uma pessoa fisica dependente de outra. Neste caso, o dependente apenas nao tera uma declaracao propria em seu nome, mas a sua renda, caso haja, sera tributada normalmente, visto que devera constar na declaracao de quem e responsavel por ele. * Aposentados, com mais de 65 anos e que sobrevivem exclusivamente do beneficio da aposentadoria.  Importante: O contribuinte que nao fizer a declaracao ou entrega-la fora do prazo fica sujeito ao pagamento de multa.  " }'+ CRLF + CRLF
	
	if (!File(cArq))
    conOut("Arquivo inexistente ou caminho incorreto!")
    return
	EndIf

  //        HttpPost( < cUrl >                , [ cGetParms ], [ cBody ], [ nTimeOut ], [ aHeadStr ], [ @cHeaderGet ] )
  cRest  := HTTPPost(cUrl+"/notices/attachment", "" ,cBody     ,nTimeOut            ,aHeader,@cHeadRet)
 

	If !empty(cRest )
    conOut("POST", cRest )
    nStatus := HttpGetStatus(@cErro)
    jResponse := JsonObject():New()
    processmessages()
    sleep(300)
	Else
    nStatus := HttpGetStatus(@cErro)
    conOut("ERRO ! "+cValToChar(nStatus) )
    return
	EndIf

Return

/*--------------------------------------------------------------------------------
POST /notices/attachment HTTP/1.1
Host: api.nexti.com
Authorization: Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJzY29wZSI6WyJvcGVuaWQiXSwibGFuZ3VhZ2UiOiJwdCIsImV4cCI6MTYyMDEzNjAwNCwiYXV0aG9yaXRpZXMiOlsidGVuYW50fjQ3Il0sImp0aSI6ImM1MWJjMTE1LTIyYzctNDcyMC1hM2UxLWEyZjE0ODdhNmUwNCIsImNsaWVudF9pZCI6ImZvcnRrbm94In0.CPhsqcJyGPl3UOdTeJOnhn-zgf0Vno_f4ZnkPJw8ljB81M6S6yjHrUQCm0DE6p1MMyLPkyGY3kd78G2SZXHZ2aH9ly4swsfASWGqsvp86TXsKIUdfqdttntEaf96AWzDi0mBJKRM-KRaHecU8COo_bS6SkNddTxrYFUQXtHRnMDeAXcSiA88lgXNdKzmcv2QuWc2EtOg9HCV_6hRnlEMw3r8C5MJcxhjLh6zhhIQ10ocgY1EXqDJHcpDGKwLBICnIw_qTAjIbSGMHJTEDZfKD5WEHUe45bzv9G37-3YpKQBjtY0QtO_FqzXcsbFkt_hoJAltQe-UylzrCr8NvU64Hw
Content-Length: 2472
Content-Type: multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW

----WebKitFormBoundary7MA4YWxkTrZu0gW
Content-Disposition: form-data; name="attachment"; filename="/C:/Users/Daniel/Downloads/informe0201000610.pdf"
Content-Type: application/pdf

(data)
----WebKitFormBoundary7MA4YWxkTrZu0gW
Content-Disposition: form-data; name="noticeJson"

{"startDate": "25022021080000" , "finishDate": "31122037080000" , "name": "Informe Rendimentos","noticeCollectorId": 1,"noticeShowId": 3,"noticeStatusId": 1,"noticeTypeId": 2,"persons": [ 148177],"personsExternalIds": [ "0201000610" ],"text": " Informe de Rendimentos e declaracao de IRPF 2021   Quem precisa declarar o imposto? * Os que receberam rendimentos tributaveis acima de R$28559.70 durante o ano de 2020 como salarios honorarios, ferias, comissoes, pro-labore, receita com aluguel de imoveis, pensoes, entre outros.  * Todos que receberam rendimentos isentos, nao tributaveis ou tributados exclusivamente na fonte superior a R$40.000,00 durante o ano de 2020, como por exemplo: alimentacao, transporte e uniformes fornecidos pela empresa de forma gratuita, reembolso de viagens em geral, salario-familia, entre outros.  * Quem recebeu em qualquer mes, dinheiro por conta de alienacao de bens e direitos  em que o IR incida . ou entao realizaram operacao em bolsas de valores, mercadorias, futuro ou semelhantes; * Quem teve ate 31.12.2020 bens ou direitos no valor total superior a 300 mil, somando todos os bens; * Todos que venderam imoveis residenciais e obtiveram ganho na operacao, mesmo que tenha comprado outro imovel em um prazo de 180 dias e usaram da regra de isencao do imposto de renda. Quem nao precisa entregar a declaracao do imposto do IRPF atualmente?  * Para nao precisar entregar a declaracao do Imposto de Renda de Pessoa Fisica, e necessario que o contribuinte se encaixe em algum dos seguintes requisitos: * Possua rendimento mensal inferior ao valor de R$1.999,18; * Seja proprietario de bens cujo valor total da somatoria seja inferior a R$300.000,00; * Seja uma pessoa fisica dependente de outra. Neste caso, o dependente apenas nao tera uma declaracao propria em seu nome, mas a sua renda, caso haja, sera tributada normalmente, visto que devera constar na declaracao de quem e responsavel por ele. * Aposentados, com mais de 65 anos e que sobrevivem exclusivamente do beneficio da aposentadoria.  Importante: O contribuinte que nao fizer a declaracao ou entrega-la fora do prazo fica sujeito ao pagamento de multa.  " }

----WebKitFormBoundary7MA4YWxkTrZu0gW




"----WebKitFormBoundary7MA4YWxkTrZu0gW
Content-Disposition: form-data; name="attachment"; filename="/spool/informe0201000610.pdf";
Content-Type: application/pdf;

----WebKitFormBoundary7MA4YWxkTrZu0gW
Content-Disposition: form-data; name="noticeJson"

{"startDate": "25022021080000" , "finishDate": "31122037080000" , "name": "Informe Rendimentos","noticeCollectorId": 1,"noticeShowId": 3,"noticeStatusId": 1,"noticeTypeId": 2,"persons": [ 148177],"personsExternalIds": [ "0201000610" ],"text": " Informe de Rendimentos e declaracao de IRPF 2021   Quem precisa declarar o imposto? * Os que receberam rendimentos tributaveis acima de R$28559.70 durante o ano de 2020 como salarios honorarios, ferias, comissoes, pro-labore, receita com aluguel de imoveis, pensoes, entre outros.  * Todos que receberam rendimentos isentos, nao tributaveis ou tributados exclusivamente na fonte superior a R$40.000,00 durante o ano de 2020, como por exemplo: alimentacao, transporte e uniformes fornecidos pela empresa de forma gratuita, reembolso de viagens em geral, salario-familia, entre outros.  * Quem recebeu em qualquer mes, dinheiro por conta de alienacao de bens e direitos  em que o IR incida . ou entao realizaram operacao em bolsas de valores, mercadorias, futuro ou semelhantes; * Quem teve ate 31.12.2020 bens ou direitos no valor total superior a 300 mil, somando todos os bens; * Todos que venderam imoveis residenciais e obtiveram ganho na operacao, mesmo que tenha comprado outro imovel em um prazo de 180 dias e usaram da regra de isencao do imposto de renda. Quem nao precisa entregar a declaracao do imposto do IRPF atualmente?  * Para nao precisar entregar a declaracao do Imposto de Renda de Pessoa Fisica, e necessario que o contribuinte se encaixe em algum dos seguintes requisitos: * Possua rendimento mensal inferior ao valor de R$1.999,18; * Seja proprietario de bens cujo valor total da somatoria seja inferior a R$300.000,00; * Seja uma pessoa fisica dependente de outra. Neste caso, o dependente apenas nao tera uma declaracao propria em seu nome, mas a sua renda, caso haja, sera tributada normalmente, visto que devera constar na declaracao de quem e responsavel por ele. * Aposentados, com mais de 65 anos e que sobrevivem exclusivamente do beneficio da aposentadoria.  Importante: O contribuinte que nao fizer a declaracao ou entrega-la fora do prazo fica sujeito ao pagamento de multa.  " }

----WebKitFormBoundary7MA4YWxkTrZu0gW"






---------------------------------------------------------------
"Content-Disposition: form-data; name="data" 

{"departmentID":1,"document":"05772444930","typeDocument":"119","indices":[{"indiceType":1,"indiceValue":"16721177"},{"indiceType":3,"indiceValue":"62149088401"}],"userID":55655318,"userName":"02660LHSTSCHUMANN"}
Content-Disposition: form-data; name="file"; filename="\spool\informe0201000610.pdf"
Content-Type: image/png"

"





--------------------------------------------------------------------------------------------------*/

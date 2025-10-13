import sys
mapeamento_aws={"Amazon Bedrock":"Serviço de acesso via API a múltiplos modelos fundacionais.","Amazon Titan":"Modelos base da AWS para gerar e resumir texto.","Amazon Q":"Assistente de IA para devs e TI integrado aos serviços AWS.","AWS Trainium":"Chip da AWS para treinar modelos de ML em larga escala."}
entrada=sys.stdin.readline().strip()
try:print(mapeamento_aws[entrada])
except KeyError:print("Ferramenta não encontrada.")
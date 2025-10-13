import sys
mapeamento_ia={"Token":"Unidade de texto que modelos de linguagem processam.","Fine-tuning":"Adapta um modelo treinado com dados novos e específicos.","Inference":"Uso do modelo treinado para gerar saída da entrada.","Dataset":"Conjunto de dados para treinar ou ajustar um modelo de IA."}
entrada=sys.stdin.readline().strip()
try:print(mapeamento_ia[entrada])
except KeyError:print("Termo não encontrado.")
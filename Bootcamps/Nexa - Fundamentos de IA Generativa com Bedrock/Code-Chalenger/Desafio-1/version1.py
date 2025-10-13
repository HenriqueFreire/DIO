import sys
mapeamento={"Modelos de Linguagem":"IA treinada em textos para prever e gerar linguagem natural.","Treinamento Supervisionado":"Aprendizado com dados rotulados para ensinar a IA a prever.","Prompt Engineering":"Técnica para guiar modelos via comandos (prompts) escritos.","Modelos Diffusion":"Modelo que gera imagens por refinamentos iterativos do ruído."}
entrada=sys.stdin.readline().strip()
try:print(mapeamento[entrada])
except KeyError:print("Conceito não encontrado ou inválido.")
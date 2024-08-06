programa {

inclua biblioteca Util --> u
inclua biblioteca Texto --> t
inclua biblioteca Tipos --> tipos

	
  funcao inicio() {

    inteiro opc, opcS, interOP, opcJOGO
    inteiro jogador = 1, resp, nmrCaracter
    inteiro sorteio, opcJogo, ganhador = 0
    caracter palavra[50], palavraBloco[50], palpite
    cadeia palavraSorteada = "", chute
    cadeia bancoPalavrasFacil[100] = {"gato", "cao", "rato", "urso", "lobo", "macaco", "aves", "sapo", "cobra", "peixe", "pato", "leao", "zebra", "girafa", "elefante", "abelha", "formiga", "mosca", "barata", "aranha", "cobra", "rato", "onca", "leao", "puma", "urso", "lobo", "raposa", "coruja", "par", "pao", "ovo", "leite", "fruta", "bolo", "pizza", "suco", "cafe", "cha", "agua", "arroz", "feijao", "carne", "peixe", "batata", "tomate", "cebola", "alho", "casa", "carro", "porta", "mesa", "cama", "livro", "lapis", "papel", "bola", "sol", "lua", "chuva", "vento", "fogo", "agua", "terra", "ar", "luz", "suor", "risos", "sim", "eles", "elas", "coisa", "anjo", "deus", "fato", "cabo", "terra", "azul", "roxo", "tio", "tia", "pai", "mae", "som", "cor", "amor", "paz", "sol", "lua", "ceu", "mar", "rio", "flor", "pedra", "fogo", "agua", "tempo", "dia", "noite", "ano"}
    cadeia bancoPalavrasDificil[50] = {"hipopotamo", "rinoceronte", "camaleão", "crocodilo", "canguru", "pinguim", "golfinho", "baleia", "tubarao", "lagarto", "escorpiao", "jacare", "tartaruga", "bufalo", "melancia", "abacaxi", "morango", "brocolis", "cenoura", "espinafre", "melancia", "mandioca", "macarrao", "salsicha", "chocolate", "biscoito", "iogurte", "torrada", "televisao", "computador", "internet", "telefone", "bicicleta", "guitarra", "relogio", "chapeu", "sapato", "mochila", "elefante", "carteira", "liberdade", "esperanca", "felicidade", "aventura", "conhecimento", "universo", "planeta", "historia", "sociedade", "natureza"}

    faca {
      limpa()
      escreva("\n..:: JOGO DA FORCA ::..")
      escreva("\n")
      escreva("\n1. Iniciar jogo.")
      escreva("\n2. Exibir regras.")
      escreva("\n3. Instruções de jogo.")
      escreva("\n9. Sair.")
      escreva("\n\nDigite sua opcão: ")
      leia(opc)

      se (opc == 1){

        faca {
          limpa()

		faca {

			jogador = 1
			ganhador = 0

			limpa()

			// primeiro escolheremos a dificuldade do jogo possibilitando o sorteio da palavra do banco de dados de acordo com a dificuldade escolhida.
			// após isso, devemos implementar o mesmo sistema de troca de jogadores utilizado no jogo de velha, porém antes da jogada devemos perguntar se o jogador quer dar chutar uma letra ou dar um palpite.
			
			// se a opção escolhida for o palpite, deve-se conferir se as palavras são iguais (ambas minúscula e sem acento), e se não, dar a vitória para o outro jogador.
			// caso seja um chute, deve-se verificar se a letra existe dentro da palavra, e se sim, mostrar ela dentro da palavra, caso contrário, trocar de jogador.

			escreva("Escolha a dificuldade do jogo:\n\n1. Fácil.\n2. Difícil.\n\n")
			leia(opcJogo)

			limpa()

			se (opcJogo == 1){

				//sorteia a palavra dentro do banco de dados de acordo com a dificuldade escolhida.
				
				sorteio = u.sorteia(0, 99)

				palavraSorteada = bancoPalavrasFacil[sorteio]

				nmrCaracter = t.numero_caracteres(palavraSorteada)

				para (inteiro i = 0; i <= nmrCaracter - 1; i++){
					
					palavra[i] = t.obter_caracter(palavraSorteada, i)
					
				}
				
				escreva("\nA palavra secreta de nível fácil foi sorteada!")

				escreva("\n\nVamos iniciar! Digite qualquer NÚMERO para continuar:\n")
				leia(interOP)

				limpa()

				faca {
					limpa()

					para (inteiro i = 0; i < nmrCaracter; i++){
							
							palavraBloco[i] = '_'
							
						}
					
					// vamos iniciar imprimindo os traços que ficam embaixo das letras
					faca {
						para (inteiro i = 0; i < nmrCaracter; i++){
							
							escreva(palavraBloco[i]," ")
						}
						
						escreva("\n\nVez do jogador ",jogador,". Você deseja dar um palpite (digite 1) ou tentar acertar a palavra (digite 2)?: ")
						leia(resp)
	
						// aqui deicidimos se o jogador deseja dar um palpite um chutar a palavra.
		
						se (resp == 1){
	
							escreva("\nDigite a letra para dar um palpite: ")
							leia(palpite)
	
							inteiro letraEncontrada = 0
	
							para (inteiro i = 0; i <= nmrCaracter; i++){
								
								// verificar se a letra do palpite existe dentro da palavra sorteada.
								
								se (palavra[i] == palpite){
									
									letraEncontrada = 1

									palavraBloco[i] = palavra[i]
									
								}
							}
	
							se (letraEncontrada == 1){
								limpa()
								
								escreva("\n\nPalpite correto! Letra: ",palpite,"\n\n")
	
								jogador = (jogador % 2) + 1
								
							} senao {
								limpa()
								
								escreva("\nPalpite incorreto!\n\n")
	
								jogador = (jogador % 2) + 1
								
							}
							
						}
					} enquanto (resp != 2)
					
					se (resp == 2){

						escreva("\nA seguir, digite a palavra:\n")
						leia(chute)

						// se o jogador acertar a palavra ele ganha, porém de der um palpite errado, a vitória será atribuida ao outro jogador.

						se (chute == palavraSorteada){
							ganhador = jogador
						} senao {
							se (jogador == 1){
								
								ganhador = 2

								escreva("\nRESPOSTA INCORRETA!\n")
								
							} senao se (jogador == 2){
								
								ganhador = 1

								escreva("\nRESPOSTA INCORRETA!\n")
								
							}
						}
					}
					
				} enquanto (ganhador == 0)

			}
			

			// SEPARAÇÃO ENTRE CADA MENU PARA FACILITAR A LEITURA DO CÓDIGO
			
			
			se (opcJogo == 2){
				
				//sorteia a palavra dentro do banco de dados de acordo com a dificuldade escolhida.
				
				sorteio = u.sorteia(0, 49)

				palavraSorteada = bancoPalavrasDificil[sorteio]

				nmrCaracter = t.numero_caracteres(palavraSorteada)

				para (inteiro i = 0; i <= nmrCaracter - 1; i++){
					
					palavra[i] = t.obter_caracter(palavraSorteada, i)
					
				}
				
				escreva("\nA palavra secreta de nível difícil foi sorteada!")

				escreva("\n\nVamos iniciar! Digite qualquer NÚMERO para continuar:\n")
				leia(interOP)

				limpa()

				faca {
					limpa()

					para (inteiro i = 0; i < nmrCaracter; i++){
							
							palavraBloco[i] = '_'
							
						}
					
					// vamos iniciar imprimindo os traços que ficam embaixo das letras
					faca {
						para (inteiro i = 0; i < nmrCaracter; i++){

							
							escreva(palavraBloco[i]," ")
							
						}
						
						escreva("\n\nVez do jogador ",jogador,". Você deseja dar um palpite (digite 1) ou tentar acertar a palavra (digite 2)?: ")
						leia(resp)
	
						// aqui deicidimos se o jogador deseja dar um palpite um chutar a palavra.
		
						se (resp == 1){
	
							escreva("\nDigite a letra para dar um palpite: ")
							leia(palpite)
	
							inteiro letraEncontrada = 0
	
							para (inteiro i = 0; i <= nmrCaracter; i++){
								
								// verificar se a letra do palpite existe dentro da palavra sorteada.
								
								se (palavra[i] == palpite){
									
									letraEncontrada = 1

									palavraBloco[i] = palavra[i]
									
								}
							}
	
							se (letraEncontrada == 1){
								limpa()
								
								escreva("\n\nPalpite correto! Letra: ",palpite,"\n\n")
	
								jogador = (jogador % 2) + 1
								
							} senao {
								limpa()
								
								escreva("\nPalpite incorreto!\n\n")
	
								jogador = (jogador % 2) + 1
								
							}
							
						}
					} enquanto (resp != 2)
					
					se (resp == 2){

						escreva("\nA seguir, digite a palavra:\n")
						leia(chute)

						// se o jogador acertar a palavra ele ganha, porém de der um palpite errado, a vitória será atribuida ao outro jogador.

						se (chute == palavraSorteada){
							ganhador = jogador
						} senao {
							se (jogador == 1){
								
								ganhador = 2

								escreva("\nRESPOSTA INCORRETA!\n")
								
							} senao se (jogador == 2){
								
								ganhador = 1

								escreva("\nRESPOSTA INCORRETA!\n")
								
							}
						}
					}
					
				} enquanto (ganhador == 0)
				
			}

			escreva("\nO GANHADOR FOI O JOGADOR ",ganhador,"!")
			escreva("\nE A PALAVRA SORTEADA FOI: ",palavraSorteada)
			escreva("\n\nDIGITE 1 PARA JOGAR NOVAMENTE E 0 PARA FINALIZAR: ")
			leia(opcJOGO)
						
		} enquanto (opcJOGO != 0)

		limpa()

          escreva("\nJogo finalizado.\nDigite 0 para voltar: ")
          leia(opcS)
        } enquanto (opcS != 0)
      }

      se (opc == 2){
    
        faca {
          limpa()

		regras()

          escreva("\nDigite 0 para voltar: ")
          leia(opcS)
        } enquanto (opcS != 0)
      }

      se (opc == 3){
 
        faca {
          limpa()

		instrucoes()

          escreva("\nDigite 0 para voltar: ")
          leia(opcS)
        } enquanto (opcS != 0)
      }
    } enquanto (opc != 9)

    limpa()

    escreva("Jogo finalizado.\n")
  }

  funcao regras(){

	escreva("1. Respeite a sua hora de jogar.\n\n2. Se você tentar dar um palpite da palavra e errar, você perde.\n\n3. Vence aquele jogador que acertar a palavra sorteada.\n")
  	
  }

  funcao instrucoes(){

	escreva("Será sorteada uma palavra do banco de dados, e os dois jogadres irão disputar para acertar a mesma palavra, dando palpites um de cada vez.\nSe o palpite (a letra) existir na palavra, ela irá se completando, caso contrário, apenas irá passar a vez para o próximo jogador.\n\nNão há vidas para palpites errados pois o objetivo é adivinhar a palavra antes do seu adversário, porém se tentar adivinhar a palavra, e errar, o jogador perde.\n\nBoa sorte!\n")
  	
  }
}

/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 254; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */
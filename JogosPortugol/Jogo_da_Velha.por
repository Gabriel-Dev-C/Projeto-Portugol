programa {

	inclua biblioteca Util --> u
	
  funcao inicio() {

    inteiro opc, opcS, ganhador = 0
    inteiro jogador = 1, jogadas = 0, linha = 0, coluna = 0
    caracter tabuleiro[3][3], blankSpace = ' '

    faca {
      limpa()
      escreva("\n..:: JOGO DA VELHA ::..")
      escreva("\n")
      escreva("\n1. Iniciar jogo local.")
      escreva("\n2. Iniciar jogo contra IA.")
      escreva("\n3. Exibir regras.")
      escreva("\n4. Instruções para jogar.")
      escreva("\n9. Sair.")
      escreva("\n\nDigite sua opcão: ")
      leia(opc)

      se (opc == 1){

        faca {
          limpa()

		// por conta do jogo ter sido realizado em forma de menu que proporciona a opção de rejogar o jogo sem precisar dar "run" no código de novo, deve-se reiniciar todas as viaráveis no inicio do código.
		
          ganhador = 0
          jogador = 1
          jogadas = 0

          // para seguir as boas práticas, devo inicializar a matriz.

		para (inteiro i = 0; i <= 2; i++){
			para (inteiro j = 0; j <= 2; j++){
				tabuleiro[i][j] = blankSpace
			}
		}

		// aqui devo criar um loop para que os jogadores joguem enquanto não houver um vencedor ou um empate

		faca {
			// primeiro devo imprimir a matriz para iterar as informações em tempo real do jogo para que fique fácil o entendimento.

			escreva("  0   1   2\n\n")
			
			para (inteiro i = 0; i <= 2; i++){
				para (inteiro j = 0; j <= 2; j++){
					escreva(" ", tabuleiro[i][j])
					se (j < 2){
						escreva(" | ")
					}
					se (j == 2){
						escreva("  ", i)
					}
				}
				se (i < 2){
					escreva("\n------------\n")
				}
			}

			// após a impressão, devo criar um sistema que alterne entre cada jogador sem repetir jogadas, e enquanto isso, verificando a cada jogada feita, se houve uma vitória, e caso,
			// após a última verificação  (número de jogadas < 9), se não houver vitória, mostrar que deu empate.

			// leitura de dados

			faca {		
				faca {
					
					escreva("\n\nVez do jogador ",jogador,". Digite a linha desejada: ")
					leia(linha)
		
					escreva("\nDigite a coluna desejada: ")
					leia(coluna)
					
				} enquanto (linha < 0 ou linha > 2 ou coluna < 0 ou coluna > 2)
			} enquanto (tabuleiro[linha][coluna] != ' ')

			// após atribuir os valores válidos, a gente salva as coordernada em forma de jogada.
			
			se (jogador == 1){
				tabuleiro[linha][coluna] = 'X'
				jogador++
			} senao {
				tabuleiro[linha][coluna] = 'O'
				jogador = 1
			}

			limpa()

			// a variável jogadas serve como controle para caso haja empate, o programa consiga identificar.

			jogadas = jogadas + 1

			// imprime -> leitura de jogada (alternando jogador) -> verifica se venceu -> se sim mostra quem venceu e encerra, se não -> verifica se o número de jogadas tá menor que 9,
			// ainda há mais jogadas para ocorrer, e então imprime e recomeça tudo de novo.

			// agora as verificações de vitória.
			
			// por linha.
			
			para (inteiro i = 0; i <= 2; i++){
				se (tabuleiro[i][0] == 'X' e tabuleiro[i][1] == 'X' e tabuleiro[i][2] == 'X'){
					ganhador = 1
				}
			}

			para (inteiro i = 0; i <= 2; i++){
				se (tabuleiro[i][0] == 'O' e tabuleiro[i][1] == 'O' e tabuleiro[i][2] == 'O'){
					ganhador = 2
				}
			}

			// por coluna.

			para (inteiro j = 0; j <= 2; j++){
				se (tabuleiro[0][j] == 'X' e tabuleiro[1][j] == 'X' e tabuleiro[2][j] == 'X'){
					ganhador = 1
				}
			}

			para (inteiro j = 0; j <= 2; j++){
				se (tabuleiro[0][j] == 'O' e tabuleiro[1][j] == 'O' e tabuleiro[2][j] == 'O'){
					ganhador = 2
				}
			}

			// por diagonal.

					se (tabuleiro[0][0] == 'X' e tabuleiro[1][1] == 'X' e tabuleiro[2][2] == 'X'){
						ganhador = 1
					}
					se (tabuleiro[0][0] == 'O' e tabuleiro[1][1] == 'O' e tabuleiro[2][2] == 'O'){
						ganhador = 2
					}
					

					se (tabuleiro[0][2] == 'X' e tabuleiro[1][1] == 'X' e tabuleiro[2][0] == 'X'){
						ganhador = 1
					}
					se (tabuleiro[0][2] == 'O' e tabuleiro[1][1] == 'O' e tabuleiro[2][0] == 'O'){
						ganhador = 2
					}
			
		} enquanto (jogadas < 9 e ganhador == 0)

		se (ganhador == 1){
			escreva("\n\nO jogador 1 venceu!")
		} senao se (ganhador == 2){
			escreva("\n\nO jogador 2 venceu!")
		} senao {
			escreva("\n\nO jogo empatou!")
		}
		

          escreva("\n\nDigite 0 para voltar ou pressione qualquer tecla númerica para jogar novamente: ")
          leia(opcS)
        } enquanto (opcS != 0)
      }

      se (opc == 1){

        faca {
          limpa()

		// por conta do jogo ter sido realizado em forma de menu que proporciona a opção de rejogar o jogo sem precisar dar "run" no código de novo, deve-se reiniciar todas as viaráveis no inicio do código.
		
          ganhador = 0
          jogador = 1
          jogadas = 0

          // para seguir as boas práticas, devo inicializar a matriz.

		para (inteiro i = 0; i <= 2; i++){
			para (inteiro j = 0; j <= 2; j++){
				tabuleiro[i][j] = blankSpace
			}
		}

		// aqui devo criar um loop para que os jogadores joguem enquanto não houver um vencedor ou um empate

		faca {
			// primeiro devo imprimir a matriz para iterar as informações em tempo real do jogo para que fique fácil o entendimento.

			escreva("  0   1   2\n\n")
			
			para (inteiro i = 0; i <= 2; i++){
				para (inteiro j = 0; j <= 2; j++){
					escreva(" ", tabuleiro[i][j])
					se (j < 2){
						escreva(" | ")
					}
					se (j == 2){
						escreva("  ", i)
					}
				}
				se (i < 2){
					escreva("\n------------\n")
				}
			}

			// após a impressão, devo criar um sistema que alterne entre cada jogador sem repetir jogadas, e enquanto isso, verificando a cada jogada feita, se houve uma vitória, e caso,
			// após a última verificação  (número de jogadas < 9), se não houver vitória, mostrar que deu empate.

			// leitura de dados

			faca {		
				faca {
					se (jogador == 1){
						escreva("\n\nVez do jogador 1. Digite a linha desejada: ")
						leia(linha)
			
						escreva("\nDigite a coluna desejada: ")
						leia(coluna)
					} senao se (jogador == 2){

						// caso seja vez do jogador dois, é retirada a possibilidade da leitura de entrada de dados e é sorteado possíveis jogadas.
						
						linha = u.sorteia(0, 2)
						coluna = u.sorteia(0, 2)
					}				
				} enquanto (linha < 0 ou linha > 2 ou coluna < 0 ou coluna > 2)
			} enquanto (tabuleiro[linha][coluna] != ' ')

			// após atribuir os valores válidos, a gente salva as coordernada em forma de jogada.
			
			se (jogador == 1){
				tabuleiro[linha][coluna] = 'X'
				jogador++
			} senao {
				tabuleiro[linha][coluna] = 'O'
				jogador = 1
			}

			limpa()

			// a variável jogadas serve como controle para caso haja empate, o programa consiga identificar.

			jogadas = jogadas + 1

			// imprime -> leitura de jogada (alternando jogador) -> verifica se venceu -> se sim mostra quem venceu e encerra, se não -> verifica se o número de jogadas tá menor que 9,
			// ainda há mais jogadas para ocorrer, e então imprime e recomeça tudo de novo.

			// agora as verificações de vitória.
			
			// por linha.
			
			para (inteiro i = 0; i <= 2; i++){
				se (tabuleiro[i][0] == 'X' e tabuleiro[i][1] == 'X' e tabuleiro[i][2] == 'X'){
					ganhador = 1
				}
			}

			para (inteiro i = 0; i <= 2; i++){
				se (tabuleiro[i][0] == 'O' e tabuleiro[i][1] == 'O' e tabuleiro[i][2] == 'O'){
					ganhador = 2
				}
			}

			// por coluna.

			para (inteiro j = 0; j <= 2; j++){
				se (tabuleiro[0][j] == 'X' e tabuleiro[1][j] == 'X' e tabuleiro[2][j] == 'X'){
					ganhador = 1
				}
			}

			para (inteiro j = 0; j <= 2; j++){
				se (tabuleiro[0][j] == 'O' e tabuleiro[1][j] == 'O' e tabuleiro[2][j] == 'O'){
					ganhador = 2
				}
			}

			// por diagonal.

					se (tabuleiro[0][0] == 'X' e tabuleiro[1][1] == 'X' e tabuleiro[2][2] == 'X'){
						ganhador = 1
					}
					se (tabuleiro[0][0] == 'O' e tabuleiro[1][1] == 'O' e tabuleiro[2][2] == 'O'){
						ganhador = 2
					}
					

					se (tabuleiro[0][2] == 'X' e tabuleiro[1][1] == 'X' e tabuleiro[2][0] == 'X'){
						ganhador = 1
					}
					se (tabuleiro[0][2] == 'O' e tabuleiro[1][1] == 'O' e tabuleiro[2][0] == 'O'){
						ganhador = 2
					}
			
		} enquanto (jogadas < 9 e ganhador == 0)

		se (ganhador == 1){
			escreva("\n\nO jogador 1 venceu!")
		} senao se (ganhador == 2){
			escreva("\n\nA IA venceu!")
		} senao {
			escreva("\n\nO jogo empatou!")
		}
		

          escreva("\n\nDigite 0 para voltar ou pressione qualquer tecla númerica para jogar novamente: ")
          leia(opcS)
        } enquanto (opcS != 0)
      }

      se (opc == 3){
    
        faca {
          limpa()

		regras()

          escreva("\nDigite 0 para voltar: ")
          leia(opcS)
        } enquanto (opcS != 0)
      }

      se (opc == 4){
 
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

	escreva("1. Respeite a sua hora de jogar!\n\n2. Não é permitido realizar alguma jogada em casas que já estavam anteriormente ocupadas.\n\n3. Vence aquele que completar 3 símbolos seguidos na horizontal, vertical ou diagonal.\n\n")
   	
   }

   funcao instrucoes(){

	escreva("Espere a sua vez para jogar e ao realizar o pedido de jogada, siga o comando pedido pelo programa (inserir número da linha e coluna)\n\nA opção de jogo contra a IA não apresenta nenhuma jogada inteligente, e sim apenas, o sorteio de valores que estejam disponíveis para realizar a jogada.\n\nOBSERVAÇÃO: Lembre-se que os valores se iniciam a partir de 0 e vão até 2, ao invés de começar em 1 e ir até 3!\n")
   	
   }
}
/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 160; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */
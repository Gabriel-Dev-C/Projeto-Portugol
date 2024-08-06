programa {

inclua biblioteca Util --> u
inclua biblioteca Tipos --> t
inclua biblioteca Matematica --> m

  inteiro contagem = 0, quant = 0
  inteiro tabuleiroP[5][5], tabuleiroG[10][10], linhaJogada = 0, colunaJogada = 0
	
  funcao inicio() {

    logico bomba = falso
    cadeia vencedorIA = "", perdedorIA = ""
    inteiro opc, opcS, cont = 0
    inteiro jogador, opcTempo, opcTempo2, opcTempo3
    inteiro linha, coluna, valorDistribuicao, quantidade
    inteiro vencedor = 0, perdedor = 0
    inteiro tabuleiroVisivelP[5][5], tabuleiroVisivelG[10][10]

    faca {
      limpa()
      escreva("\n..:: CAMPO MINADO ::..")
      escreva("\n")
      escreva("\n1. Iniciar jogo 5x5.\n")
      escreva("\n2. Iniciar jogo 10x10.\n")
      escreva("\n3. Iniciar jogo contra IA (MODO DIFÍCIL).\n")
      escreva("\n4. Exibir regras.\n")
      escreva("\n5. Instruções para jogar.\n")
      escreva("\n9. Sair.")
      escreva("\n\nDigite sua opcão: ")
      leia(opc)

      se (opc == 1){

        faca {
          limpa()

          jogador = 1

          cont = 0

          bomba = falso

		/* Para iniciar deve-se pensar na lógica inteira do programa antes de escrever o código em si.
		 primeiro deve-se criar um tabuleiro que indique as casas que já foram escolhidas e as bombas (caso alguém escolha uma casa que tenha bomba).

		 é possível iterar as informações ào tabuleiro com os números 1 e 2 (casas que os jogadores 1 e 2 escolheram que não possuam bomba), e com 0 para casas que tenham bombas.

		 antes de verificar a presença de bomba, verificar se a jogada é válida.
		 para adicionar uma inteligência no jogo, não seram nescessárias verificações se a casa existe, mas sim se ela já está ocupada.

		 ao cair em uma bomba, mostrar todas as bombas do tabuleiro para maior imersão no jogo. */

		// primeiro deve-se inicializar a matriz


		para (inteiro i = 0; i <= 4; i++){
			para (inteiro j = 0; j <= 4; j++){
				tabuleiroP[i][j] = 0
				tabuleiroVisivelP[i][j] = 0
			}
		}

		/* vale mencionar que a variável onde apenas chamamos de tabuleiro, funciona como um tabuleiro backend, onde iremos processar as informações e assim, quando forem processadas
		 serão escritas no tabuleiro visível (aquele que os jogadores verão durante o jogo) */

		// primeiro sorteamos a quantidade em porcentagem de bombas que serão distribuídas (em relação às 25 células disponíveis)

		valorDistribuicao = u.sorteia(10, 20)

		escreva("A QUANTIDADE DE BOMBAS SORTEADAS EM RELAÇÃO AO TABULEIRO SERÁ DE ", valorDistribuicao,"%\n")

		// agora definimos a quantidade de bombas presente

		quantidade = ((valorDistribuicao * 25) / 100)

		escreva("\nRESULTANDO EM UM TOTAL DE ",quantidade," BOMBAS PRESENTES NO JOGO!")

		// agora devemos distribuir cada uma das bombas à posições aleatórias no tabuleiro.

		faca {
			faca {
						
				linha = u.sorteia(0, 4)
				coluna = u.sorteia(0, 4)
				
			} enquanto (tabuleiroP[linha][coluna] != 0)

			tabuleiroP[linha][coluna] = 3

			cont = cont + 1

		} enquanto (cont < quantidade)

		escreva("\n\n\nAS BOMBAS FORAM POSICIONADAS E ESTAMOS PRONTOS PARA INICIAR O JOGO (DIGITE QUALQUER NÚMERO PARA CONTINUAR):\n")
		leia(opcTempo)

		// agora cria-se um loop para que o jogo ocorra enquanto alguém não cair em uma bomba.

		 faca {
			limpa()

			// agora imprime-se o tabuleiro, o resetando a cada looping para iterar novas informações.

			escreva("   0   1   2   3   4\n")
			escreva("-----------------------\n")

			para (inteiro i = 0; i <= 4; i++){
				
				escreva(" | ")
				
				para (inteiro j = 0; j <= 4; j++){
					
					escreva(tabuleiroVisivelP[i][j]," | ")

					se (j == 4){
						escreva(" ", i)
					}
				}
				
				escreva("\n-----------------------\n")
			}

			faca {
				faca {
					
					escreva("\nVez do jogador ",jogador,".\n\nDigite a linha: ")
					leia(linhaJogada)
					
					escreva("Digite a coluna: ")
					leia(colunaJogada)
					
				} enquanto (linhaJogada < 0 ou linhaJogada > 4 ou colunaJogada < 0 ou colunaJogada > 4)
			} enquanto (tabuleiroVisivelP[linhaJogada][colunaJogada] != 0)

			// agora fazemos uma verificação

			se (tabuleiroP[linhaJogada][colunaJogada] == 3){
				
				bomba = verdadeiro
				
				se (jogador == 1){
					
					vencedor = 2
					perdedor = 1
					
				} senao se (jogador == 2){
					
					vencedor = 1
					perdedor = 2
					
				}
			} senao /* SE NÃO FOR BOMBA PODEMOS FAZER A CONTAGEM DE POSSÍVEIS BOMBAS VIZINHAS À CASA JOGADA */ {

				tabuleiroVisivelP[linhaJogada][colunaJogada] = jogador
				tabuleiroP[linhaJogada][colunaJogada] = jogador

				verificarBombasP()

				escreva("\n\nEXISTEM ",contagem," BOMBAS NA VIZINHANÇA DA CASA ESCOLHIDA (TECLE QUALQUER DÍGITO PARA PROSSEGUIR): ")
				leia(opcTempo2)
			}
				

			se (jogador == 1){
				
				jogador = 2
				
			} senao {
				
				jogador = 1
				
			}
			
		 } enquanto (bomba == falso)

		// podemos reescrever o tabuleiro mostrando todas as bombas após o término do jogo.

		limpa()
		
		escreva("   0   1   2   3   4\n")
			escreva("-----------------------\n")

			para (inteiro i = 0; i <= 4; i++){
				
				escreva(" | ")
				
				para (inteiro j = 0; j <= 4; j++){
					
					escreva(tabuleiroP[i][j]," | ")

					se (j == 4){
						escreva(" ", i)
					}
				}
				
				escreva("\n-----------------------\n")
			}
			
		escreva("\nBOOOM! O jogador ", perdedor," caiu em uma bomba. Portanto o vencedor é o jogador ", vencedor,"! PARABÉNS!")
          escreva("\n\nDigite 0 para voltar ou pressione qualquer tecla númerica para jogar novamente: ")
          leia(opcS)
          
        } enquanto (opcS != 0)
      }


	
	// MAIOR ESPAÇO ENTRE OS DOIS JOGOS PARA FACILITAR NA LEITURA DO CÓDIGO.

      

      se (opc == 2){
    
        faca {
          limpa()

		jogador = 1

		cont = 0

		bomba = falso


		para (inteiro i = 0; i <= 9; i++){
			para (inteiro j = 0; j <= 9; j++){
				tabuleiroG[i][j] = 0
				tabuleiroVisivelG[i][j] = 0
			}
		}

		valorDistribuicao = u.sorteia(10, 20)

		escreva("A QUANTIDADE DE BOMBAS SORTEADAS EM RELAÇÃO AO TABULEIRO SERÁ DE ", valorDistribuicao,"%\n")

		// agora definimos a quantidade de bombas presente

		quantidade = ((valorDistribuicao * 100) / 100)

		escreva("\nRESULTANDO EM UM TOTAL DE ",quantidade," BOMBAS PRESENTES NO JOGO!")

		// agora devemos distribuir cada uma das bombas à posições aleatórias no tabuleiro.

		faca {
			faca {
						
				linha = u.sorteia(0, 9)
				coluna = u.sorteia(0, 9)
				
			} enquanto (tabuleiroG[linha][coluna] != 0)

			tabuleiroG[linha][coluna] = 3

			cont = cont + 1

		} enquanto (cont < quantidade)

		escreva("\n\n\nAS BOMBAS FORAM POSICIONADAS E ESTAMOS PRONTOS PARA INICIAR O JOGO (DIGITE QUALQUER NÚMERO PARA CONTINUAR):\n")
		leia(opcTempo)

		// agora cria-se um loop para que o jogo ocorra enquanto alguém não cair em uma bomba.

		 faca {
			limpa()

			// agora imprime-se o tabuleiro, o resetando a cada looping para iterar novas informações.

			escreva("   0   1   2   3   4   5   6   7   8   9\n")
			escreva("------------------------------------------\n")

			para (inteiro i = 0; i <= 9; i++){
				
				escreva(" | ")
				
				para (inteiro j = 0; j <= 9; j++){
					
					escreva(tabuleiroVisivelG[i][j]," | ")

					se (j == 9){
						escreva(" ", i)
					}
				}
				
				escreva("\n------------------------------------------\n")
			}

			faca {
				faca {
					
					escreva("\nVez do jogador ",jogador,".\n\nDigite a linha: ")
					leia(linhaJogada)
					
					escreva("Digite a coluna: ")
					leia(colunaJogada)
					
				} enquanto (linhaJogada < 0 ou linhaJogada > 9 ou colunaJogada < 0 ou colunaJogada > 9)
			} enquanto (tabuleiroVisivelG[linhaJogada][colunaJogada] != 0)

			// agora fazemos uma verificação

			se (tabuleiroG[linhaJogada][colunaJogada] == 3){
				
				bomba = verdadeiro
				
				se (jogador == 1){
					
					vencedor = 2
					perdedor = 1
					
				} senao se (jogador == 2){
					
					vencedor = 1
					perdedor = 2
					
				}
			} senao {

				tabuleiroVisivelG[linhaJogada][colunaJogada] = jogador
				tabuleiroG[linhaJogada][colunaJogada] = jogador

				verificarBombasG()

				escreva("\n\nEXISTEM ",contagem," BOMBAS NA VIZINHANÇA DA CASA ESCOLHIDA (TECLE QUALQUER DÍGITO PARA PROSSEGUIR): ")
				leia(opcTempo3)
				
			}

			se (jogador == 1){
				
				jogador = 2
				
			} senao {
				
				jogador = 1
				
			}
			
		 } enquanto (bomba == falso)


		limpa()
		
		escreva("   0   1   2   3   4   5   6   7   8   9\n")
			escreva("------------------------------------------\n")

			para (inteiro i = 0; i <= 9; i++){
				
				escreva(" | ")
				
				para (inteiro j = 0; j <= 9; j++){
					
					escreva(tabuleiroG[i][j]," | ")

					se (j == 9){
						escreva(" ", i)
					}
				}
				
				escreva("\n------------------------------------------\n")
			}
			
		escreva("\nBOOOM! O jogador ", perdedor," caiu em uma bomba. Portanto o vencedor é o jogador ", vencedor,"! PARABÉNS!")
          escreva("\n\nDigite 0 para voltar ou pressione qualquer tecla númerica para jogar novamente: ")
          leia(opcS)

        } enquanto (opcS != 0)
      }



      // SEPARANDO OS MENUS PARA FÁCIL VISUALIZAÇÃO

      

      se (opc == 3){
 
        faca {
          limpa()

          /* NA OPÇÃO ONDE O JOGADOR DECIDE JOGAR CONTRA A IA DO JOGO, RETIRAMOS O SISTEMA DE LEITURA ALTERNADO E PERMITIMOS A LEITURA APENAS DO JOGADOR 1, CAJO A VEZ SEJA DO JOGADOR 2
           ENTÃO SORTEAMOS UMA CASA QUE AINDA NÃO TENHA SIDO ESCOLHIDA.

           NO MENU FOI DITO MODO DIFICIL POIS O JOGO OCORRE NO TABULEIRO 5X5 (25 CASAS TOTAIS) COM UM NÚMERO FIXO DE BOMBAS DE 12 BOMBAS. SENDO ASSIM RETIRADO O SISTEMA DE SORTEIO DE BOMBAS*/

		jogador = 1

		bomba = falso


		para (inteiro i = 0; i <= 4; i++){
			para (inteiro j = 0; j <= 4; j++){
				tabuleiroP[i][j] = 0
				tabuleiroVisivelP[i][j] = 0
			}
		}

		quantidade = 0

		escreva("\nNO MODO DIFÍCIL CONTRA A IA, FORAM SORTEADAS EM POSIÇÕES ALEATÓRIAS 12 BOMBAS. BOA SORTE!")

		// agora devemos distribuir cada uma das bombas à posições aleatórias no tabuleiro.

		faca {
			faca {
						
				linha = u.sorteia(0, 4)
				coluna = u.sorteia(0, 4)
				
			} enquanto (tabuleiroP[linha][coluna] != 0)

			tabuleiroP[linha][coluna] = 3

			quantidade = quantidade + 1

		} enquanto (quantidade < 12)


		escreva("\n\n\nAS BOMBAS FORAM POSICIONADAS E ESTAMOS PRONTOS PARA INICIAR O JOGO (DIGITE QUALQUER NÚMERO PARA CONTINUAR):\n")
		leia(opcTempo)

		// agora cria-se um loop para que o jogo ocorra enquanto alguém não cair em uma bomba.

		 faca {
			limpa()

			// agora imprime-se o tabuleiro, o resetando a cada looping para iterar novas informações.

			escreva("   0   1   2   3   4\n")
			escreva("-----------------------\n")

			para (inteiro i = 0; i <= 4; i++){
				
				escreva(" | ")
				
				para (inteiro j = 0; j <= 4; j++){
					
					escreva(tabuleiroVisivelP[i][j]," | ")

					se (j == 4){
						escreva(" ", i)
					}
				}
				
				escreva("\n-----------------------\n")
			}

			faca {
				faca {
					se (jogador == 1){
						
						escreva("\nSua vez.\n\nDigite a linha: ")
						leia(linhaJogada)
						
						escreva("Digite a coluna: ")
						leia(colunaJogada)
						
					} senao se (jogador == 2){
						
						linhaJogada = u.sorteia(0, 4)
						colunaJogada = u.sorteia(0, 4)

						u.aguarde(2000)
						
					}
					
				} enquanto (linhaJogada < 0 ou linhaJogada > 4 ou colunaJogada < 0 ou colunaJogada > 4)
			} enquanto (tabuleiroVisivelP[linhaJogada][colunaJogada] != 0)

			// agora fazemos uma verificação

			se (tabuleiroP[linhaJogada][colunaJogada] == 3){
				
				bomba = verdadeiro
				
				se (jogador == 1){
					
					vencedorIA = "IA"
					perdedorIA = "JOGADOR"
					
				} senao se (jogador == 2){
					
					vencedorIA = "JOGADOR"
					perdedorIA = "IA"
					
				}
			} senao {

				tabuleiroVisivelP[linhaJogada][colunaJogada] = jogador
				tabuleiroP[linhaJogada][colunaJogada] = jogador
				
			}

			se (jogador == 1){
				
				jogador = 2
				
			} senao {
				
				jogador = 1
				
			}
			
		 } enquanto (bomba == falso)

		// podemos reescrever o tabuleiro mostrando todas as bombas após o término do jogo.

		limpa()
		
		escreva("   0   1   2   3   4\n")
			escreva("-----------------------\n")

			para (inteiro i = 0; i <= 4; i++){
				
				escreva(" | ")
				
				para (inteiro j = 0; j <= 4; j++){
					
					escreva(tabuleiroP[i][j]," | ")

					se (j == 4){
						escreva(" ", i)
					}
				}
				
				escreva("\n-----------------------\n")
			}
			
		escreva("\nBOOOM! O jogador ", perdedorIA," caiu em uma bomba. Portanto o vencedor é: ", vencedorIA,"! PARABÉNS!")
          escreva("\n\nDigite 0 para voltar ou pressione qualquer tecla númerica para jogar novamente: ")
          leia(opcS)
          
        } enquanto (opcS != 0)
      }
      
      se (opc == 4){
 
        faca {
          limpa()

		regras()

          escreva("\nDigite 0 para voltar: ")
          leia(opcS)
        } enquanto (opcS != 0)
      }

      se (opc == 5){
     
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

		escreva("1. Respeite a sua hora de jogar.\n\n2. Ganha o jogador que não escolher uma bomba.\n\n3. Não é possível roubar.\n")
  	
  }

  funcao instrucoes(){

		escreva("Para jogar basta escolher o tamanho de tabuleiro que deseja jogar e assim a própria inteligência do jogo irá sortear algumas casas\n(a quantidade de casas sorteadas para bombas pode variar de 10% a 20% do número total de possibilidades do jogo).\n\nO jogo irá alternar entre cada jogador para que realizem uma jogada, e caso haja uma bomba na casa escolhida, o outro jogador vence automaticamente.\n\nCaso não haja uma bomba, então o jogo irá passar a vez de jogar para o próximo jogador.\n\nO número 1 representa as casas sem bomba selecionadas pelo jogador 1. Por outro lado, o número 2 representa as casas sem bombas selecionadas pelo jogador 2.\nAs bombas serão representadas pelo número 3, e o 0 indica as casas que não foram selecionadas.\n\nTenha um bom jogo!\n\n")
  	
  }

  funcao verificarBombasP(){

  	contagem = 0

		// DIAGONAL SUPERIOR ESQUERDA

				se (linhaJogada - 1 >= 0 e colunaJogada - 1 >= 0){
					se (tabuleiroP[linhaJogada - 1][colunaJogada - 1] == 3){
						contagem = contagem + 1
					}
				}

				// CENTRO SUPERIOR

				se (linhaJogada - 1 >= 0){
					se (tabuleiroP[linhaJogada - 1][colunaJogada] == 3){
						contagem = contagem + 1
					}
				}

				// DIAGONAL SUPERIOR DIREITA

				se (linhaJogada - 1 >= 0 e colunaJogada + 1 <= 4){
					se (tabuleiroP[linhaJogada - 1][colunaJogada + 1] == 3){
						contagem = contagem + 1
					}
				}

				// CENTRO ESQUERDO

				se (colunaJogada - 1 >= 0){
					se (tabuleiroP[linhaJogada][colunaJogada - 1] == 3){
						contagem = contagem + 1
					}
				}

				// CENTRO DIREITO

				se (colunaJogada + 1 <= 4){
					se (tabuleiroP[linhaJogada][colunaJogada + 1] == 3){
						contagem = contagem + 1
					}
				}

				// DIAGONAL INFERIOR ESQUERDA

				se (linhaJogada + 1 <= 4 e colunaJogada - 1 >= 0){
					se (tabuleiroP[linhaJogada + 1][colunaJogada - 1] == 3){
						contagem = contagem + 1
					}
				}

				// CENTRO INFERIOR

				se (linhaJogada + 1 <= 4){
					se (tabuleiroP[linhaJogada + 1][colunaJogada] == 3){
						contagem = contagem + 1
					}
				}

				// DIAGONAL INFERIOR DIREITA

				se (linhaJogada + 1 <= 4 e colunaJogada + 1 <= 4){
					se (tabuleiroP[linhaJogada + 1][colunaJogada + 1] == 3){
						contagem = contagem + 1
					}
				}
  	
  	}

  	funcao verificarBombasG(){

  	contagem = 0

		// DIAGONAL SUPERIOR ESQUERDA

				se (linhaJogada - 1 >= 0 e colunaJogada - 1 >= 0){
					se (tabuleiroG[linhaJogada - 1][colunaJogada - 1] == 3){
						contagem = contagem + 1
					}
				}

				// CENTRO SUPERIOR

				se (linhaJogada - 1 >= 0){
					se (tabuleiroG[linhaJogada - 1][colunaJogada] == 3){
						contagem = contagem + 1
					}
				}

				// DIAGONAL SUPERIOR DIREITA

				se (linhaJogada - 1 >= 0 e colunaJogada + 1 <= 9){
					se (tabuleiroG[linhaJogada - 1][colunaJogada + 1] == 3){
						contagem = contagem + 1
					}
				}

				// CENTRO ESQUERDO

				se (colunaJogada - 1 >= 0){
					se (tabuleiroG[linhaJogada][colunaJogada - 1] == 3){
						contagem = contagem + 1
					}
				}

				// CENTRO DIREITO

				se (colunaJogada + 1 <= 9){
					se (tabuleiroG[linhaJogada][colunaJogada + 1] == 3){
						contagem = contagem + 1
					}
				}

				// DIAGONAL INFERIOR ESQUERDA

				se (linhaJogada + 1 <= 9 e colunaJogada - 1 >= 0){
					se (tabuleiroG[linhaJogada + 1][colunaJogada - 1] == 3){
						contagem = contagem + 1
					}
				}

				// CENTRO INFERIOR

				se (linhaJogada + 1 <= 9){
					se (tabuleiroG[linhaJogada + 1][colunaJogada] == 3){
						contagem = contagem + 1
					}
				}

				// DIAGONAL INFERIOR DIREITA

				se (linhaJogada + 1 <= 9 e colunaJogada + 1 <= 9){
					se (tabuleiroG[linhaJogada + 1][colunaJogada + 1] == 3){
						contagem = contagem + 1
					}
				}
  	
  	}
}
/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 16841; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */
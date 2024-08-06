programa {
	
  inclua biblioteca Util --> u
  inclua biblioteca Tipos --> t

    caracter tipo // 'B' para bote, 'S' para submarino, 'P' para porta-aviões
    inteiro linha // Linha inicial da embarcação no tabuleiro
    inteiro coluna // Coluna inicial da embarcação no tabuleiro
    inteiro direcao

    inteiro bote1Linha, bote1Coluna, bote2Linha, bote2Coluna, sub1Linha, sub1Coluna, sub2Linha, sub2Coluna, pa1Linha, pa1Coluna, pa2Linha, pa2Coluna // usaremos essas variáveis para sortear as posições
    inteiro bote3Linha, bote3Coluna, sub3Linha, sub3Coluna, pa3Linha, pa3Coluna // no tabuleiro 20x20 usaremos 3 embarcações de cada tipo.
    caracter tabuleiro[10][10], tabuleiroVisivel[10][10] // assim como no campo minado, para evitar de mostrar aos jogadores a posições das bombas (nesse caso embarcações) criamos duas matrizes.
    caracter tabuleiroG[20][20], tabuleiroVisivelG[20][20]

  funcao inicio() {
  	
    inteiro opc, opcS, jogadorAtual = 1, opcTempo, opcTempo2
    inteiro pontuacaoJogador1 = 0
    inteiro pontuacaoJogador2 = 0
    inteiro numeroDeJogadas = 10, numeroDeJogadas2 = 20 // Número fixo de jogadas
    inteiro jogadasRealizadas = 0, pontuacao = 0
    logico fimDeJogo = falso, ataqueAcertado = falso

    faca {
      limpa()
      escreva("\n..:: BATALHA NAVAL ::..")
      escreva("\n")
      escreva("\n1. Iniciar jogo 10x10")
      escreva("\n\n2. Iniciar jogo 20x20")
      escreva("\n\n3. Exibir regras")
      escreva("\n\n4. Instruções para jogar")
      escreva("\n\n9. Sair")
      escreva("\n\nDigite sua opcão: ")
      leia(opc)

      se (opc == 1) {
        faca {
          limpa()

          /*
          *	ANTES DE INICIAR O CÓDIGO, É VALIDO PENSAR NA LÓGICA POR TRÁS.
          *	
          *	CONSIDERANDO QUE TEREMOS VÁRIOS DE TIPOS DE SINALIZAÇÕES NO TABULEIRO, COMO 0 PARA ÁGUA, X PARA TIROS SEM SUCESSO, B PARA BOTES, S PARA SUBMARINO E P PARA PORTA-AVIOES
          *	ENTÃO DEVEMOS CRIAR UMA MATRIZ QUE ACEITE A ENTRADA DE CARACTERES PARA MELHOR VISUALIZAÇÃO POR PARTE DOS JOGADORES AO CÓDIGO
          *	
          *	NO INICIO ATRIBUÍMOS O VALOR 0 (AGUA) PARA AS DUAS MATRIZES E PARA A MATRIZ BACKEND SORTEAREMOS 6 POSIÇÕES PARA CADA UM DOS 3 TIPOS DE EMBARCAÇÕES (2 VEZES CADA)
          *	(NO TABULEIRO 20X20 SÃO 3 EMBARCAÇÕES DE CADA TIPO)
          *	
          *	PORÉM DEVEMOS TOMAR CUIDADO PARA NÃO SOBREPOR, ENTÃO PARA EVITAR ISSO, SORTEAREMOS UMA EMBARCAÇÃO DE CADA VEZ
          *	
          *	PARA ATRIBUIR SEUS VALORES ÀS CASAS VIZINHAS SORTEAREMOS PRIMEIRO A DIREÇÃO QUE A EMBARCAÇÃO SEGUIRÁ, E APÓS ISSO, SUAS CASAS
          *	
          *	O BOTE IRÁ OCUPAR UMA CASA, O SUBMARINO DUAS, E O PORTA-AVIÕES 3 CASAS. DANDO 5, 10 E 15 PONTOS RESPECTIVAMENTE.
          *	
          *	PENSANDO NA LOGICA DO JOGO E FAZENDO O CÓDIGO, FICA CLARO QUE A PARTE QUE MAIS IRÁ EXIGIR LÓGICA E VERFICAÇÕES SERÁ O SORTEIO DA POSIÇÃO DAS EMBARCAÇÕES, ENTÃO É PRECISO CUIDADO.
          */

          jogadorAtual = 1

          jogadasRealizadas = 0

          pontuacaoJogador1 = 0

          pontuacaoJogador2 = 0
          
          // Inicializa o tabuleiro

          para (inteiro i = 0; i <= 9; i++) {
		      para (inteiro j = 0; j <= 9; j++) {
		        tabuleiro[i][j] = '0' // 0 representa água
		        tabuleiroVisivel[i][j] = '0'
		      }
 		   }

          // Posiciona as embarcações

          // POSSO CRIAR TUDO DENTRO DE UMA FUNÇÃO E CHAMAR ELA AQUI.

		sortearEmbarcacoes10x10()

		// ----------------------------------------------------------------------------
			
		limpa()

		escreva("AS EMBARCAÇÕES JÁ FORAM POSICIONADAS E ESTAMOS PRONTOS PARA INICIAR. TECLE QUALQUER DIGITO PARA CONTINUAR: ")
		leia(opcTempo)

          // Loop do jogo
          
          faca {
            limpa()
            
              escreva("\n   0   1   2   3   4   5   6   7   8   9")
		    escreva("\n  -----------------------------------------\n")
		   
		    para (inteiro i = 0; i <= 9; i++){
				
				escreva(" | ")
				
				para (inteiro j = 0; j <= 9; j++){
					
					escreva(tabuleiroVisivel[i][j]," | ")

					se (j == 9){
						escreva(" ", i)
					}
				}
				
				escreva("\n-----------------------------------------\n")
			}
			
			 escreva("\nNÚMERO DA JOGADA ATUAL: ", jogadasRealizadas)
			 escreva("\n\nVez do jogador ", jogadorAtual, ".\n")
            
            faca {
	            faca {
		          
 		            escreva("\nDigite a linha (0-9): ")
		            leia(linha)
		            
		            escreva("\nDigite a coluna (0-9): ")
		            leia(coluna)
		            
	            } enquanto (linha < 0 e linha > 9 e coluna < 0 e coluna > 9)
            } enquanto (tabuleiroVisivel[linha][coluna] != '0')

            limpa()

              // Processa a jogada
		    se (tabuleiro[linha][coluna] == 'B' ou tabuleiro[linha][coluna] == 'S' ou tabuleiro[linha][coluna] == 'P') {
		    	
		    	ataqueAcertado = verdadeiro
		    	
		    }
              
              se (ataqueAcertado == verdadeiro) {

              	escolha (tabuleiro[linha][coluna]){

                  	caso 'B':
					pontuacao = 5

					tabuleiroVisivel[linha][coluna] = 'B'
                  	pare

                  	caso 'S':
					pontuacao = 10

					tabuleiroVisivel[linha][coluna] = 'S'
					
                  	pare

                  	caso 'P':
					pontuacao = 15

					tabuleiroVisivel[linha][coluna] = 'P'
					
                  	pare
                  }
              	
                se (jogadorAtual == 1) {
                	
                  pontuacaoJogador1 = pontuacaoJogador1 + pontuacao
                  
                } senao {
                	
                  pontuacaoJogador2 = pontuacaoJogador2 + pontuacao
                  
                }

                escreva("O JOGADOR ",jogadorAtual," ACERTOU A EMBARCAÇÃO REFERENTE À LETRA: '",tabuleiro[linha][coluna],"'.")

			 se (jogadorAtual == 1){
			 	
			 	escreva("\nPortanto foram adicionados ",pontuacao," ao seu total. Agora o jogador 1 possuí: ",pontuacaoJogador1," pontos.")
			 	
			 } senao {

				escreva("\nPortanto foram adicionados ",pontuacao," ao seu total. Agora o jogador 2 possuí: ",pontuacaoJogador2," pontos.")
			 	
			 }

                escreva("\n\nEscreva qualquer dígito para prosseguir: ")
                leia(opcTempo2)
                
              }

              se (tabuleiro[linha][coluna] == '0'){

				tabuleiro[linha][coluna] = 'X'

              		tabuleiroVisivel[linha][coluna] = 'X'
              	
              }

              ataqueAcertado = falso
              
              jogadasRealizadas = jogadasRealizadas + 1
              
              jogadorAtual = (jogadorAtual % 2) + 1

              pontuacao = 0
            
          } enquanto (jogadasRealizadas < numeroDeJogadas)


          // Imprime o resultado do jogo
          
          limpa()
          
         	    escreva("\n   0   1   2   3   4   5   6   7   8   9")
		    escreva("\n  -----------------------------------------\n")
		   
		    para (inteiro i = 0; i <= 9; i++){
				
				escreva(" | ")
				
				para (inteiro j = 0; j <= 9; j++){
					
					escreva(tabuleiro[i][j]," | ")

					se (j == 9){
						escreva(" ", i)
					}
				}
				
				escreva("\n-----------------------------------------\n")
			}
          
          escreva("\nJogo Finalizado!\n")
          escreva("\nJogador 1: ", pontuacaoJogador1, " pontos.")
          escreva("\nJogador 2: ", pontuacaoJogador2, " pontos.\n")
          
          se (pontuacaoJogador1 > pontuacaoJogador2) {
          	
            escreva("\nJogador 1 venceu!")
            
          } senao se (pontuacaoJogador2 > pontuacaoJogador1) {
          	
            escreva("\nJogador 2 venceu!")
            
          } senao {
            escreva("\nEmpate!")
          }

          escreva("\n\nDigite 0 para voltar ou pressione qualquer tecla númerica para jogar novamente: ")
          leia(opcS)
        } enquanto (opcS != 0)
      }

      // -----------------------------------------------------------------------------------------------------------------------------------

	 // SEPARAÇÃO ENTRE OS MENUS DO JOGO

      // -----------------------------------------------------------------------------------------------------------------------------------

      se (opc == 2){

      	faca {
          limpa()

          /*
          * A LÓGICA APLICADA NO TABULEIRO 20X20 SERÁ A MESMA PORÉM COM VALORES DIFERENTES.
          * 
          * O TABULEIRO SENDO MAIOR NOS PERMITE REALIZAR O SORTEIO DE 3 EMBARCAÇÕES DE CADA TIPO (NO 10X10 SÃO 2)
          */

          jogadorAtual = 1

          jogadasRealizadas = 0

          pontuacaoJogador1 = 0

          pontuacaoJogador2 = 0
          
          // Inicializa o tabuleiro

          para (inteiro i = 0; i <= 19; i++) {
		      para (inteiro j = 0; j <= 19; j++) {
		        tabuleiroG[i][j] = '0' // 0 representa água
		        tabuleiroVisivelG[i][j] = '0'
		      }
 		   }

          // Posiciona as embarcações

          // POSSO CRIAR TUDO DENTRO DE UMA FUNÇÃO E CHAMAR ELA AQUI.

		sortearEmbarcacoes20x20()

		// ----------------------------------------------------------------------------
			
		limpa()

		escreva("AS EMBARCAÇÕES JÁ FORAM POSICIONADAS E ESTAMOS PRONTOS PARA INICIAR. TECLE QUALQUER DIGITO PARA CONTINUAR: ")
		leia(opcTempo)

          // Loop do jogo
          
          faca {
            limpa()
            
               escreva("\n   0   1   2   3   4   5   6   7   8   9   10  11  12  13  14  15  16  17  18  19")
			escreva("\n  --------------------------------------------------------------------------------\n")
		   
		    para (inteiro i = 0; i <= 19; i++){
				
				escreva(" | ")
				
				para (inteiro j = 0; j <= 19; j++){
					
					escreva(tabuleiroVisivelG[i][j]," | ")

					se (j == 19){
						escreva("", i)
					}
				}
				
				escreva("\n----------------------------------------------------------------------------------\n")
			}
			
			 escreva("\nNÚMERO DA JOGADA ATUAL: ", jogadasRealizadas)
			 escreva("\n\nVez do jogador ", jogadorAtual, ".\n")
            
            faca {
	            faca {
		          
 		            escreva("\nDigite a linha (0-9): ")
		            leia(linha)
		            
		            escreva("\nDigite a coluna (0-9): ")
		            leia(coluna)
		            
	            } enquanto (linha < 0 e linha > 19 e coluna < 0 e coluna > 19)
            } enquanto (tabuleiroVisivelG[linha][coluna] != '0')

            limpa()

              // Processa a jogada
		    se (tabuleiroG[linha][coluna] == 'B' ou tabuleiroG[linha][coluna] == 'S' ou tabuleiroG[linha][coluna] == 'P') {
		    	
		    	ataqueAcertado = verdadeiro
		    	
		    }
              
              se (ataqueAcertado == verdadeiro) {

              	escolha (tabuleiroG[linha][coluna]){

                  	caso 'B':
					pontuacao = 5

					tabuleiroVisivelG[linha][coluna] = 'B'
                  	pare

                  	caso 'S':
					pontuacao = 10

					tabuleiroVisivelG[linha][coluna] = 'S'
					
                  	pare

                  	caso 'P':
					pontuacao = 15

					tabuleiroVisivelG[linha][coluna] = 'P'
					
                  	pare
                  }
              	
                se (jogadorAtual == 1) {
                	
                  pontuacaoJogador1 = pontuacaoJogador1 + pontuacao
                  
                } senao {
                	
                  pontuacaoJogador2 = pontuacaoJogador2 + pontuacao
                  
                }

                escreva("O JOGADOR ",jogadorAtual," ACERTOU A EMBARCAÇÃO REFERENTE À LETRA: '",tabuleiroG[linha][coluna],"'.")

			 se (jogadorAtual == 1){
			 	
			 	escreva("\nPortanto foram adicionados ",pontuacao," ao seu total. Agora o jogador 1 possuí: ",pontuacaoJogador1," pontos.")
			 	
			 } senao {

				escreva("\nPortanto foram adicionados ",pontuacao," ao seu total. Agora o jogador 2 possuí: ",pontuacaoJogador2," pontos.")
			 	
			 }

                escreva("\n\nEscreva qualquer dígito para prosseguir: ")
                leia(opcTempo2)
                
              }

              se (tabuleiroG[linha][coluna] == '0'){

				tabuleiroG[linha][coluna] = 'X'

              		tabuleiroVisivelG[linha][coluna] = 'X'
              	
              }

              ataqueAcertado = falso
              
              jogadasRealizadas = jogadasRealizadas + 1
              
              jogadorAtual = (jogadorAtual % 2) + 1

              pontuacao = 0
            
          } enquanto (jogadasRealizadas < numeroDeJogadas2)


          // Imprime o resultado do jogo
          
          limpa()
          
         	     escreva("\n   0   1   2   3   4   5   6   7   8   9   10  11  12  13  14  15  16  17  18  19")
			escreva("\n  --------------------------------------------------------------------------------\n")
		   
		    para (inteiro i = 0; i <= 19; i++){
				
				escreva(" | ")
				
				para (inteiro j = 0; j <= 19; j++){
					
					escreva(tabuleiroG[i][j]," | ")

					se (j == 19){
						escreva("", i)
					}
				}
				
				escreva("\n----------------------------------------------------------------------------------\n")
			}
          
          escreva("\nJogo Finalizado!\n")
          escreva("\nJogador 1: ", pontuacaoJogador1, " pontos.")
          escreva("\nJogador 2: ", pontuacaoJogador2, " pontos.\n")
          
          se (pontuacaoJogador1 > pontuacaoJogador2) {
          	
            escreva("\nJogador 1 venceu!")
            
          } senao se (pontuacaoJogador2 > pontuacaoJogador1) {
          	
            escreva("\nJogador 2 venceu!")
            
          } senao {
            escreva("\nEmpate!")
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

  funcao regras() {
    escreva("1. O jogo é jogado em um único tabuleiro de 10x10 ou 20x20.\n\n")
    escreva("2. Cada jogador escolhe uma célula do tabuleiro para atirar.\n\n")
    escreva("3. Se a célula escolhida for uma embarcação, o jogador ganha pontos.\n\n")
    escreva("4. O jogo termina após 10 (ou 20) jogadas, e o jogador com mais pontos vence.\n\n")
    escreva("5. As embarcações são posicionadas aleatoriamente no tabuleiro no início do jogo.\n\n")
    escreva("6. No tabuleiro 10x10 existem 2 embarcações de cada tipo. Por outro lado, no tabuleiro 20x20 existem 3 embarcações para cada tipo.\n\n")
    escreva("7. Os jogadores não podem ver as embarcações do oponente.\n\n")
  }

  funcao instrucoes() {
    escreva("1. Escolha uma das opções do menu para iniciar o jogo.\n\n")
    escreva("2. Insira a linha e a coluna (de 0 a 9) da célula que você deseja atirar.\n\n")
    escreva("3. O número 0 representa a água. O X irá representar tiros que não acertaram embarcações.\n\n")
    escreva("4. A letra B irá representar bote, o S, submarino e o P, porta-aviões.\n\n")
    escreva("5. O jogo irá mostrar a pontuação de cada jogador após cada rodada.\n\n")
    escreva("6. Boa sorte!\n")
  }

  funcao sortearEmbarcacoes10x10(){

	// SORTEAMOS OS DOIS BOTES.

		// -------- BOTE 1 ----------

		faca {

			bote1Linha = u.sorteia(0, 9)
			bote1Coluna = u.sorteia(0, 9)

		} enquanto (tabuleiro[bote1Linha][bote1Coluna] != '0')

		se (tabuleiro[bote1Linha][bote1Coluna] == '0'){
			
				tabuleiro[bote1Linha][bote1Coluna] = 'B'
				
			}

		// -------- BOTE 2 ---------

		faca {

			bote2Linha = u.sorteia(0, 9)
			bote2Coluna = u.sorteia(0, 9)

		} enquanto (tabuleiro[bote2Linha][bote2Coluna] != '0')

		se (tabuleiro[bote2Linha][bote2Coluna] == '0'){
			
				tabuleiro[bote2Linha][bote2Coluna] = 'B'
				
			}

		// ----------------------------------------------------------------------

		//SORTEAMOS OS DOIS SUBMARINOS.

		// ------- SUBMARINO 1 -----------

		// primeiro definimos a direção da embarcação.

		direcao = u.sorteia(0, 1) // 0 = horizontal; 1 = vertical

		faca {

			// excluí a possibilidade de sorteio de linhas e colunas que ficam no extremo do tabuleiro pois eu faço uma verificação de qualquer forma depois do sorteio.

			sub1Linha = u.sorteia(1, 8)
			sub1Coluna = u.sorteia(1, 8)
			
		} enquanto (tabuleiro[sub1Linha][sub1Coluna] != '0')

		se (direcao == 0) /* HORIZONTAL */ {

			se (tabuleiro[sub1Linha][sub1Coluna] == '0'){

				tabuleiro[sub1Linha][sub1Coluna] = 'S'

				se (tabuleiro[sub1Linha][sub1Coluna - 1] == '0') /* ATRIBUI O VALOR À CASA DA ESQUERDA CASO ESTEJA VAZIA */ {

					tabuleiro[sub1Linha][sub1Coluna - 1] = 'S'
					
				} senao se (tabuleiro[sub1Linha][sub1Coluna + 1] == '0') /* ATRIBUI O VALOR À CASA DA DIREITA CASO ESTEJA VAZIA */ {

					tabuleiro[sub1Linha][sub1Coluna + 1] = 'S'
					
				} // EXISTE A POSSIBILIDADE DE NÃO HAVER CASAS DISPONÍVEIS NA HORIZONTAL, ENTÃO NESSE CASO FORÇAMOS UM SORTEIO PARA A VERTICAL.

				senao se (tabuleiro[sub1Linha - 1][sub1Coluna] == '0'){ // CASA ACIMA

					tabuleiro[sub1Linha - 1][sub1Coluna] = 'S'
					
				}

				senao se (tabuleiro[sub1Linha + 1][sub1Coluna] == '0'){ // CASA ABAIXO

					tabuleiro[sub1Linha + 1][sub1Coluna] = 'S'
					
				}
				
			}
			
		}

		senao se (direcao == 1) /* VERTICAL */ {

			se (tabuleiro[sub1Linha][sub1Coluna] == '0'){

				tabuleiro[sub1Linha][sub1Coluna] = 'S'

				se (tabuleiro[sub1Linha - 1][sub1Coluna] == '0') /* ATRIBUI O VALOR À CASA ACIMA CASO ESTEJA VAZIA */ {

					tabuleiro[sub1Linha - 1][sub1Coluna] = 'S'
					
				} senao se (tabuleiro[sub1Linha + 1][sub1Coluna] == '0') /* ATRIBUI O VALOR À CASA ABAIXO CASO ESTEJA VAZIA */ {

					tabuleiro[sub1Linha + 1][sub1Coluna] = 'S'
					
				} // EXISTE A POSSIBILIDADE DE NÃO HAVER CASAS DISPONÍVEIS NA VERTICAL, ENTÃO NESSE CASO FORÇAMOS UM SORTEIO PARA A HORIZONTAL.

				senao se (tabuleiro[sub1Linha][sub1Coluna - 1] == '0'){ // CASA À ESQUERDA

					tabuleiro[sub1Linha][sub1Coluna - 1] = 'S'
					
				}

				senao se (tabuleiro[sub1Linha][sub1Coluna + 1] == '0'){ // CASA À DIREITA

					tabuleiro[sub1Linha][sub1Coluna + 1] = 'S'
					
				}
				
			}
			
		}

		// ----------- SUBMARINO 2 ------------

		direcao = u.sorteia(0, 1) // 0 = horizontal; 1 = vertical

		faca {

			// excluí a possibilidade de sorteio de linhas e colunas que ficam no extremo do tabuleiro pois eu faço uma verificação de qualquer forma depois do sorteio.

			sub2Linha = u.sorteia(1, 8)
			sub2Coluna = u.sorteia(1, 8)
			
		} enquanto (tabuleiro[sub2Linha][sub2Coluna] != '0')

		se (direcao == 0) /* HORIZONTAL */ {

			se (tabuleiro[sub2Linha][sub2Coluna] == '0'){

				tabuleiro[sub2Linha][sub2Coluna] = 'S'

				se (tabuleiro[sub2Linha][sub2Coluna - 1] == '0') /* ATRIBUI O VALOR À CASA DA ESQUERDA CASO ESTEJA VAZIA */ {

					tabuleiro[sub2Linha][sub2Coluna - 1] = 'S'
					
				} senao se (tabuleiro[sub2Linha][sub2Coluna + 1] == '0') /* ATRIBUI O VALOR À CASA DA DIREITA CASO ESTEJA VAZIA */ {

					tabuleiro[sub2Linha][sub2Coluna + 1] = 'S'
					
				} // EXISTE A POSSIBILIDADE DE NÃO HAVER CASAS DISPONÍVEIS NA HORIZONTAL, ENTÃO NESSE CASO FORÇAMOS UM SORTEIO PARA A VERTICAL.

				senao se (tabuleiro[sub2Linha - 1][sub2Coluna] == '0'){ // CASA ACIMA

					tabuleiro[sub2Linha - 1][sub2Coluna] = 'S'
					
				}

				senao se (tabuleiro[sub2Linha + 1][sub2Coluna] == '0'){ // CASA ABAIXO

					tabuleiro[sub2Linha + 1][sub2Coluna] = 'S'
					
				}
				
			}
			
		}

		senao se (direcao == 1) /* VERTICAL */ {

			se (tabuleiro[sub2Linha][sub2Coluna] == '0'){

				tabuleiro[sub2Linha][sub2Coluna] = 'S'

				se (tabuleiro[sub2Linha - 1][sub2Coluna] == '0') /* ATRIBUI O VALOR À CASA ACIMA CASO ESTEJA VAZIA */ {

					tabuleiro[sub2Linha - 1][sub2Coluna] = 'S'
					
				} senao se (tabuleiro[sub2Linha + 1][sub2Coluna] == '0') /* ATRIBUI O VALOR À CASA ABAIXO CASO ESTEJA VAZIA */ {

					tabuleiro[sub2Linha + 1][sub2Coluna] = 'S'
					
				} // EXISTE A POSSIBILIDADE DE NÃO HAVER CASAS DISPONÍVEIS NA VERTICAL, ENTÃO NESSE CASO FORÇAMOS UM SORTEIO PARA A HORIZONTAL.

				senao se (tabuleiro[sub2Linha][sub2Coluna - 1] == '0'){ // CASA À ESQUERDA

					tabuleiro[sub2Linha][sub2Coluna - 1] = 'S'
					
				}

				senao se (tabuleiro[sub2Linha][sub2Coluna + 1] == '0'){ // CASA À DIREITA

					tabuleiro[sub2Linha][sub2Coluna + 1] = 'S'
					
				}
				
			}
			
		}

		// ------------------------------------------------------------------------

		// SORTEAMOS OS DOIS PORTA-AVIÕES

		// --------- PORTA-AVIÃO 1 ----------

		// primeiro definimos a direção da embarcação.

		direcao = u.sorteia(0, 1) // 0 = horizontal; 1 = vertical

		faca {

			// excluí a possibilidade de sorteio de linhas e colunas que ficam no extremo do tabuleiro pois eu faço uma verificação de qualquer forma depois do sorteio.

			pa1Linha = u.sorteia(2, 7)
			pa1Coluna = u.sorteia(2, 7)
			
		} enquanto (tabuleiro[pa1Linha][pa1Coluna] != '0')

		se (direcao == 0) /* HORIZONTAL */ {

			se (tabuleiro[pa1Linha][pa1Coluna] == '0'){

				tabuleiro[pa1Linha][pa1Coluna] = 'P'

				se (tabuleiro[pa1Linha][pa1Coluna - 1] == '0') /* ATRIBUI O VALOR À CASA DA ESQUERDA CASO ESTEJA VAZIA */ {

					tabuleiro[pa1Linha][pa1Coluna - 1] = 'P'

					se (tabuleiro[pa1Linha][pa1Coluna - 2] == '0'){ /* CASO VAIZA, SEGUIMOS ADIANTE PARA A ESQUERDA, CASO CONTRARIO VAMOS PARA DIREITA */

						tabuleiro[pa1Linha][pa1Coluna - 2] = 'P'
						
					} senao se (tabuleiro[pa1Linha][pa1Coluna + 1] == '0'){

						tabuleiro[pa1Linha][pa1Coluna + 1] = 'P'
						
					} // CASO NEM A ESQUERDA E NEM A DIREITA DESSE BLOCO DE DUAS CASAS JÁ PREVIAMENTE SORTEADAS ESTEJA DISPONÍVEL, VERIFICAMOS NA DIREÇÃO OPOSTA (NESSE CASO VERTICAL)
					
				} senao se (tabuleiro[pa1Linha][pa1Coluna + 1] == '0') /* ATRIBUI O VALOR À CASA DA DIREITA CASO ESTEJA VAZIA */ {

					tabuleiro[pa1Linha][pa1Coluna + 1] = 'P'

					se (tabuleiro[pa1Linha][pa1Coluna + 2] == '0'){ /* CASO VAZIA, SEGUIMOS ADIANTE PARA A DIREITA, CASO CONTRARIO VAMOS PARA ESQUERDA */

						tabuleiro[pa1Linha][pa1Coluna + 2] = 'P'
						
					} senao se (tabuleiro[pa1Linha][pa1Coluna - 1] == '0'){

						tabuleiro[pa1Linha][pa1Coluna - 1] = 'P'
						
					} // CASO NEM A ESQUERDA E NEM A DIREITA DESSE BLOCO DE DUAS CASAS JÁ PREVIAMENTE SORTEADAS ESTEJA DISPONÍVEL, VERIFICAMOS NA DIREÇÃO OPOSTA (NESSE CASO VERTICAL)
					
				} 
				
				// EXISTE A POSSIBILIDADE DE NÃO HAVER CASAS DISPONÍVEIS NA HORIZONTAL, ENTÃO NESSE CASO FORÇAMOS UM SORTEIO PARA A VERTICAL.

				senao se (tabuleiro[pa1Linha - 1][pa1Coluna] == '0'){ // CASA ACIMA

					tabuleiro[pa1Linha - 1][pa1Coluna] = 'S'

					se (tabuleiro[pa1Linha - 2][pa1Coluna] == '0'){ /* CASO VAZIA, SEGUIMOS ADIANTE PARA CIMA, CASO CONTRARIO VAMOS PARA BAIXO */

						tabuleiro[pa1Linha - 2][pa1Coluna] = 'P'
						
					} senao se (tabuleiro[pa1Linha + 1][pa1Coluna] == '0'){

						tabuleiro[pa1Linha + 1][pa1Coluna] = 'P'
						
					} // CASO NEM ACIMA E NEM ABAIXO DESSE BLOCO DE DUAS CASAS JÁ PREVIAMENTE SORTEADAS ESTEJA DISPONÍVEL, VERIFICAMOS NA DIREÇÃO OPOSTA (NESSE CASO HORIZONTAL)
					
				}

				senao se (tabuleiro[pa1Linha + 1][pa1Coluna] == '0'){ // CASA ABAIXO

					tabuleiro[pa1Linha + 1][pa1Coluna] = 'S'

					se (tabuleiro[pa1Linha + 2][pa1Coluna] == '0'){ /* CASO VAZIA, SEGUIMOS ADIANTE PARA BAIXO, CASO CONTRARIO VAMOS PARA CIMA */

						tabuleiro[pa1Linha + 2][pa1Coluna] = 'P'
						
					} senao se (tabuleiro[pa1Linha - 1][pa1Coluna] == '0'){

						tabuleiro[pa1Linha - 1][pa1Coluna] = 'P'
						
					} // CASO NEM ACIMA E NEM ABAIXO DESSE BLOCO DE DUAS CASAS JÁ PREVIAMENTE SORTEADAS ESTEJA DISPONÍVEL, VERIFICAMOS NA DIREÇÃO OPOSTA (NESSE CASO HORIZONTAL)
					
				}
				
			}
			
		}

		senao se (direcao == 1) /* VERTICAL */ {

			se (tabuleiro[pa1Linha][pa1Coluna] == '0'){

				tabuleiro[pa1Linha][pa1Coluna] = 'P'

				se (tabuleiro[pa1Linha - 1][pa1Coluna] == '0') /* ATRIBUI O VALOR À CASA ACIMA CASO ESTEJA VAZIA */ {

					tabuleiro[pa1Linha - 1][pa1Coluna] = 'P'

					se (tabuleiro[pa1Linha - 2][pa1Coluna] == '0'){ /* CASO VAZIA, SEGUIMOS ADIANTE PARA CIMA, CASO CONTRARIO VAMOS PARA BAIXO */

						tabuleiro[pa1Linha - 2][pa1Coluna] = 'P'
						
					} senao se (tabuleiro[pa1Linha + 1][pa1Coluna] == '0'){

						tabuleiro[pa1Linha + 1][pa1Coluna] = 'P'
						
					}
					
				} senao se (tabuleiro[pa1Linha + 1][pa1Coluna] == '0') /* ATRIBUI O VALOR À CASA ABAIXO CASO ESTEJA VAZIA */ {

					tabuleiro[pa1Linha + 1][pa1Coluna] = 'P'

					se (tabuleiro[pa1Linha + 2][pa1Coluna] == '0'){ /* CASO VAZIA, SEGUIMOS ADIANTE PARA BAIXO, CASO CONTRARIO VAMOS PARA CIMA */

						tabuleiro[pa1Linha + 2][pa1Coluna] = 'P'
						
					} senao se (tabuleiro[pa1Linha - 1][pa1Coluna] == '0'){

						tabuleiro[pa1Linha - 1][pa1Coluna] = 'P'
						
					}
					
				} // EXISTE A POSSIBILIDADE DE NÃO HAVER CASAS DISPONÍVEIS NA VERTICAL, ENTÃO NESSE CASO FORÇAMOS UM SORTEIO PARA A HORIZONTAL.

				senao se (tabuleiro[pa1Linha][pa1Coluna - 1] == '0'){ // CASA À ESQUERDA

					tabuleiro[pa1Linha][pa1Coluna - 1] = 'S'

					se (tabuleiro[pa1Linha][pa1Coluna - 2] == '0'){ /* CASO VAZIA, SEGUIMOS ADIANTE PARA A ESQUERDA, CASO CONTRARIO VAMOS PARA DIREITA */

						tabuleiro[pa1Linha][pa1Coluna - 2] = 'P'
						
					} senao se (tabuleiro[pa1Linha][pa1Coluna + 1] == '0'){

						tabuleiro[pa1Linha][pa1Coluna + 1] = 'P'
						
					}
					
				}

				senao se (tabuleiro[pa1Linha][pa1Coluna + 1] == '0'){ // CASA À DIREITA

					tabuleiro[pa1Linha][pa1Coluna + 1] = 'S'

					se (tabuleiro[pa1Linha][pa1Coluna + 2] == '0'){ /* CASO VAZIA, SEGUIMOS ADIANTE PARA A DIREITA, CASO CONTRARIO VAMOS PARA ESQUERDA */

						tabuleiro[pa1Linha][pa1Coluna + 2] = 'P'
						
					} senao se (tabuleiro[pa1Linha][pa1Coluna - 1] == '0'){

						tabuleiro[pa1Linha][pa1Coluna - 1] = 'P'
						
					}
					
				}
				
			}
			
		}

		// ----------------------------------------------------------------------------


		// --------- PORTA-AVIÃO 2 ----------

		// primeiro definimos a direção da embarcação.

		direcao = u.sorteia(0, 1) // 0 = horizontal; 1 = vertical

		faca {

			// excluí a possibilidade de sorteio de linhas e colunas que ficam no extremo do tabuleiro pois eu faço uma verificação de qualquer forma depois do sorteio.

			pa2Linha = u.sorteia(2, 7)
			pa2Coluna = u.sorteia(2, 7)
			
		} enquanto (tabuleiro[pa2Linha][pa2Coluna] != '0')

		se (direcao == 0) /* HORIZONTAL */ {

			se (tabuleiro[pa2Linha][pa2Coluna] == '0'){

				tabuleiro[pa2Linha][pa2Coluna] = 'P'

				se (tabuleiro[pa2Linha][pa2Coluna - 1] == '0') /* ATRIBUI O VALOR À CASA DA ESQUERDA CASO ESTEJA VAZIA */ {

					tabuleiro[pa2Linha][pa2Coluna - 1] = 'P'

					se (tabuleiro[pa2Linha][pa2Coluna - 2] == '0'){ /* CASO VAIZA, SEGUIMOS ADIANTE PARA A ESQUERDA, CASO CONTRARIO VAMOS PARA DIREITA */

						tabuleiro[pa2Linha][pa2Coluna - 2] = 'P'
						
					} senao se (tabuleiro[pa2Linha][pa2Coluna + 1] == '0'){

						tabuleiro[pa2Linha][pa2Coluna + 1] = 'P'
						
					} // CASO NEM A ESQUERDA E NEM A DIREITA DESSE BLOCO DE DUAS CASAS JÁ PREVIAMENTE SORTEADAS ESTEJA DISPONÍVEL, VERIFICAMOS NA DIREÇÃO OPOSTA (NESSE CASO VERTICAL)
					
				} senao se (tabuleiro[pa2Linha][pa2Coluna + 1] == '0') /* ATRIBUI O VALOR À CASA DA DIREITA CASO ESTEJA VAZIA */ {

					tabuleiro[pa2Linha][pa2Coluna + 1] = 'P'

					se (tabuleiro[pa2Linha][pa2Coluna + 2] == '0'){ /* CASO VAZIA, SEGUIMOS ADIANTE PARA A DIREITA, CASO CONTRARIO VAMOS PARA ESQUERDA */

						tabuleiro[pa2Linha][pa2Coluna + 2] = 'P'
						
					} senao se (tabuleiro[pa2Linha][pa2Coluna - 1] == '0'){

						tabuleiro[pa2Linha][pa2Coluna - 1] = 'P'
						
					} // CASO NEM A ESQUERDA E NEM A DIREITA DESSE BLOCO DE DUAS CASAS JÁ PREVIAMENTE SORTEADAS ESTEJA DISPONÍVEL, VERIFICAMOS NA DIREÇÃO OPOSTA (NESSE CASO VERTICAL)
					
				} 
				
				// EXISTE A POSSIBILIDADE DE NÃO HAVER CASAS DISPONÍVEIS NA HORIZONTAL, ENTÃO NESSE CASO FORÇAMOS UM SORTEIO PARA A VERTICAL.

				senao se (tabuleiro[pa2Linha - 1][pa2Coluna] == '0'){ // CASA ACIMA

					tabuleiro[pa2Linha - 1][pa2Coluna] = 'S'

					se (tabuleiro[pa2Linha - 2][pa2Coluna] == '0'){ /* CASO VAZIA, SEGUIMOS ADIANTE PARA CIMA, CASO CONTRARIO VAMOS PARA BAIXO */

						tabuleiro[pa2Linha - 2][pa2Coluna] = 'P'
						
					} senao se (tabuleiro[pa2Linha + 1][pa2Coluna] == '0'){

						tabuleiro[pa2Linha + 1][pa2Coluna] = 'P'
						
					} // CASO NEM ACIMA E NEM ABAIXO DESSE BLOCO DE DUAS CASAS JÁ PREVIAMENTE SORTEADAS ESTEJA DISPONÍVEL, VERIFICAMOS NA DIREÇÃO OPOSTA (NESSE CASO HORIZONTAL)
					
				}

				senao se (tabuleiro[pa2Linha + 1][pa2Coluna] == '0'){ // CASA ABAIXO

					tabuleiro[pa2Linha + 1][pa2Coluna] = 'S'

					se (tabuleiro[pa2Linha + 2][pa2Coluna] == '0'){ /* CASO VAZIA, SEGUIMOS ADIANTE PARA BAIXO, CASO CONTRARIO VAMOS PARA CIMA */

						tabuleiro[pa2Linha + 2][pa2Coluna] = 'P'
						
					} senao se (tabuleiro[pa2Linha - 1][pa2Coluna] == '0'){

						tabuleiro[pa2Linha - 1][pa2Coluna] = 'P'
						
					} // CASO NEM ACIMA E NEM ABAIXO DESSE BLOCO DE DUAS CASAS JÁ PREVIAMENTE SORTEADAS ESTEJA DISPONÍVEL, VERIFICAMOS NA DIREÇÃO OPOSTA (NESSE CASO HORIZONTAL)
					
				}
				
			}
			
		}

		senao se (direcao == 1) /* VERTICAL */ {

			se (tabuleiro[pa2Linha][pa2Coluna] == '0'){

				tabuleiro[pa2Linha][pa2Coluna] = 'P'

				se (tabuleiro[pa2Linha - 1][pa2Coluna] == '0') /* ATRIBUI O VALOR À CASA ACIMA CASO ESTEJA VAZIA */ {

					tabuleiro[pa2Linha - 1][pa2Coluna] = 'P'

					se (tabuleiro[pa2Linha - 2][pa2Coluna] == '0'){ /* CASO VAZIA, SEGUIMOS ADIANTE PARA CIMA, CASO CONTRARIO VAMOS PARA BAIXO */

						tabuleiro[pa2Linha - 2][pa2Coluna] = 'P'
						
					} senao se (tabuleiro[pa2Linha + 1][pa2Coluna] == '0'){

						tabuleiro[pa2Linha + 1][pa2Coluna] = 'P'
						
					}
					
				} senao se (tabuleiro[pa2Linha + 1][pa2Coluna] == '0') /* ATRIBUI O VALOR À CASA ABAIXO CASO ESTEJA VAZIA */ {

					tabuleiro[pa2Linha + 1][pa2Coluna] = 'P'

					se (tabuleiro[pa2Linha + 2][pa2Coluna] == '0'){ /* CASO VAZIA, SEGUIMOS ADIANTE PARA BAIXO, CASO CONTRARIO VAMOS PARA CIMA */

						tabuleiro[pa2Linha + 2][pa2Coluna] = 'P'
						
					} senao se (tabuleiro[pa2Linha - 1][pa2Coluna] == '0'){

						tabuleiro[pa2Linha - 1][pa2Coluna] = 'P'
						
					}
					
				} // EXISTE A POSSIBILIDADE DE NÃO HAVER CASAS DISPONÍVEIS NA VERTICAL, ENTÃO NESSE CASO FORÇAMOS UM SORTEIO PARA A HORIZONTAL.

				senao se (tabuleiro[pa2Linha][pa2Coluna - 1] == '0'){ // CASA À ESQUERDA

					tabuleiro[pa2Linha][pa2Coluna - 1] = 'S'

					se (tabuleiro[pa2Linha][pa2Coluna - 2] == '0'){ /* CASO VAZIA, SEGUIMOS ADIANTE PARA A ESQUERDA, CASO CONTRARIO VAMOS PARA DIREITA */

						tabuleiro[pa2Linha][pa2Coluna - 2] = 'P'
						
					} senao se (tabuleiro[pa2Linha][pa2Coluna + 1] == '0'){

						tabuleiro[pa2Linha][pa2Coluna + 1] = 'P'
						
					}
					
				}

				senao se (tabuleiro[pa2Linha][pa2Coluna + 1] == '0'){ // CASA À DIREITA

					tabuleiro[pa2Linha][pa2Coluna + 1] = 'S'

					se (tabuleiro[pa2Linha][pa2Coluna + 2] == '0'){ /* CASO VAZIA, SEGUIMOS ADIANTE PARA A DIREITA, CASO CONTRARIO VAMOS PARA ESQUERDA */

						tabuleiro[pa2Linha][pa2Coluna + 2] = 'P'
						
					} senao se (tabuleiro[pa2Linha][pa2Coluna - 1] == '0'){

						tabuleiro[pa2Linha][pa2Coluna - 1] = 'P'
						
					}
					
				}
				
			}
			
		}		
 	
   }

   // --------------------------------------------------------------------------------------------------------------

   // SEPARAÇÃO ENTRE CADA FUNÇÃO

    // --------------------------------------------------------------------------------------------------------------

   funcao sortearEmbarcacoes20x20(){

	// SORTEAMOS OS DOIS BOTES.

		// -------- BOTE 1 ----------

		faca {

			bote1Linha = u.sorteia(0, 9)
			bote1Coluna = u.sorteia(0, 9)

		} enquanto (tabuleiro[bote1Linha][bote1Coluna] != '0')

		se (tabuleiro[bote1Linha][bote1Coluna] == '0'){
			
				tabuleiro[bote1Linha][bote1Coluna] = 'B'
				
			}

		// -------- BOTE 2 ---------

		faca {

			bote2Linha = u.sorteia(0, 9)
			bote2Coluna = u.sorteia(0, 9)

		} enquanto (tabuleiro[bote2Linha][bote2Coluna] != '0')

		se (tabuleiro[bote2Linha][bote2Coluna] == '0'){
			
				tabuleiro[bote2Linha][bote2Coluna] = 'B'
				
			}

		// -------- BOTE 3 ---------

		faca {

			bote3Linha = u.sorteia(0, 9)
			bote3Coluna = u.sorteia(0, 9)

		} enquanto (tabuleiroG[bote3Linha][bote3Coluna] != '0')

		se (tabuleiroG[bote3Linha][bote3Coluna] == '0'){
			
				tabuleiroG[bote3Linha][bote3Coluna] = 'B'
				
			}

		// ----------------------------------------------------------------------

		//SORTEAMOS OS DOIS SUBMARINOS.

		// ------- SUBMARINO 1 -----------

		// primeiro definimos a direção da embarcação.

		direcao = u.sorteia(0, 1) // 0 = horizontal; 1 = vertical

		faca {

			// excluí a possibilidade de sorteio de linhas e colunas que ficam no extremo do tabuleiro pois eu faço uma verificação de qualquer forma depois do sorteio.

			sub1Linha = u.sorteia(1, 8)
			sub1Coluna = u.sorteia(1, 8)
			
		} enquanto (tabuleiroG[sub1Linha][sub1Coluna] != '0')

		se (direcao == 0) /* HORIZONTAL */ {

			se (tabuleiroG[sub1Linha][sub1Coluna] == '0'){

				tabuleiroG[sub1Linha][sub1Coluna] = 'S'

				se (tabuleiroG[sub1Linha][sub1Coluna - 1] == '0') /* ATRIBUI O VALOR À CASA DA ESQUERDA CASO ESTEJA VAZIA */ {

					tabuleiroG[sub1Linha][sub1Coluna - 1] = 'S'
					
				} senao se (tabuleiroG[sub1Linha][sub1Coluna + 1] == '0') /* ATRIBUI O VALOR À CASA DA DIREITA CASO ESTEJA VAZIA */ {

					tabuleiroG[sub1Linha][sub1Coluna + 1] = 'S'
					
				} // EXISTE A POSSIBILIDADE DE NÃO HAVER CASAS DISPONÍVEIS NA HORIZONTAL, ENTÃO NESSE CASO FORÇAMOS UM SORTEIO PARA A VERTICAL.

				senao se (tabuleiroG[sub1Linha - 1][sub1Coluna] == '0'){ // CASA ACIMA

					tabuleiroG[sub1Linha - 1][sub1Coluna] = 'S'
					
				}

				senao se (tabuleiroG[sub1Linha + 1][sub1Coluna] == '0'){ // CASA ABAIXO

					tabuleiroG[sub1Linha + 1][sub1Coluna] = 'S'
					
				}
				
			}
			
		}

		senao se (direcao == 1) /* VERTICAL */ {

			se (tabuleiroG[sub1Linha][sub1Coluna] == '0'){

				tabuleiroG[sub1Linha][sub1Coluna] = 'S'

				se (tabuleiroG[sub1Linha - 1][sub1Coluna] == '0') /* ATRIBUI O VALOR À CASA ACIMA CASO ESTEJA VAZIA */ {

					tabuleiroG[sub1Linha - 1][sub1Coluna] = 'S'
					
				} senao se (tabuleiroG[sub1Linha + 1][sub1Coluna] == '0') /* ATRIBUI O VALOR À CASA ABAIXO CASO ESTEJA VAZIA */ {

					tabuleiroG[sub1Linha + 1][sub1Coluna] = 'S'
					
				} // EXISTE A POSSIBILIDADE DE NÃO HAVER CASAS DISPONÍVEIS NA VERTICAL, ENTÃO NESSE CASO FORÇAMOS UM SORTEIO PARA A HORIZONTAL.

				senao se (tabuleiroG[sub1Linha][sub1Coluna - 1] == '0'){ // CASA À ESQUERDA

					tabuleiroG[sub1Linha][sub1Coluna - 1] = 'S'
					
				}

				senao se (tabuleiroG[sub1Linha][sub1Coluna + 1] == '0'){ // CASA À DIREITA

					tabuleiroG[sub1Linha][sub1Coluna + 1] = 'S'
					
				}
				
			}
			
		}

		// ----------- SUBMARINO 2 ------------

		direcao = u.sorteia(0, 1) // 0 = horizontal; 1 = vertical

		faca {

			// excluí a possibilidade de sorteio de linhas e colunas que ficam no extremo do tabuleiro pois eu faço uma verificação de qualquer forma depois do sorteio.

			sub2Linha = u.sorteia(1, 8)
			sub2Coluna = u.sorteia(1, 8)
			
		} enquanto (tabuleiroG[sub2Linha][sub2Coluna] != '0')

		se (direcao == 0) /* HORIZONTAL */ {

			se (tabuleiroG[sub2Linha][sub2Coluna] == '0'){

				tabuleiroG[sub2Linha][sub2Coluna] = 'S'

				se (tabuleiroG[sub2Linha][sub2Coluna - 1] == '0') /* ATRIBUI O VALOR À CASA DA ESQUERDA CASO ESTEJA VAZIA */ {

					tabuleiroG[sub2Linha][sub2Coluna - 1] = 'S'
					
				} senao se (tabuleiroG[sub2Linha][sub2Coluna + 1] == '0') /* ATRIBUI O VALOR À CASA DA DIREITA CASO ESTEJA VAZIA */ {

					tabuleiroG[sub2Linha][sub2Coluna + 1] = 'S'
					
				} // EXISTE A POSSIBILIDADE DE NÃO HAVER CASAS DISPONÍVEIS NA HORIZONTAL, ENTÃO NESSE CASO FORÇAMOS UM SORTEIO PARA A VERTICAL.

				senao se (tabuleiroG[sub2Linha - 1][sub2Coluna] == '0'){ // CASA ACIMA

					tabuleiroG[sub2Linha - 1][sub2Coluna] = 'S'
					
				}

				senao se (tabuleiroG[sub2Linha + 1][sub2Coluna] == '0'){ // CASA ABAIXO

					tabuleiroG[sub2Linha + 1][sub2Coluna] = 'S'
					
				}
				
			}
			
		}

		senao se (direcao == 1) /* VERTICAL */ {

			se (tabuleiroG[sub2Linha][sub2Coluna] == '0'){

				tabuleiroG[sub2Linha][sub2Coluna] = 'S'

				se (tabuleiroG[sub2Linha - 1][sub2Coluna] == '0') /* ATRIBUI O VALOR À CASA ACIMA CASO ESTEJA VAZIA */ {

					tabuleiroG[sub2Linha - 1][sub2Coluna] = 'S'
					
				} senao se (tabuleiroG[sub2Linha + 1][sub2Coluna] == '0') /* ATRIBUI O VALOR À CASA ABAIXO CASO ESTEJA VAZIA */ {

					tabuleiroG[sub2Linha + 1][sub2Coluna] = 'S'
					
				} // EXISTE A POSSIBILIDADE DE NÃO HAVER CASAS DISPONÍVEIS NA VERTICAL, ENTÃO NESSE CASO FORÇAMOS UM SORTEIO PARA A HORIZONTAL.

				senao se (tabuleiroG[sub2Linha][sub2Coluna - 1] == '0'){ // CASA À ESQUERDA

					tabuleiroG[sub2Linha][sub2Coluna - 1] = 'S'
					
				}

				senao se (tabuleiroG[sub2Linha][sub2Coluna + 1] == '0'){ // CASA À DIREITA

					tabuleiroG[sub2Linha][sub2Coluna + 1] = 'S'
					
				}
				
			}
			
		}

		// ------- SUBMARINO 3 -----------

		// primeiro definimos a direção da embarcação.

		direcao = u.sorteia(0, 1) // 0 = horizontal; 1 = vertical

		faca {

			// excluí a possibilidade de sorteio de linhas e colunas que ficam no extremo do tabuleiro pois eu faço uma verificação de qualquer forma depois do sorteio.

			sub3Linha = u.sorteia(1, 8)
			sub3Coluna = u.sorteia(1, 8)
			
		} enquanto (tabuleiroG[sub3Linha][sub3Coluna] != '0')

		se (direcao == 0) /* HORIZONTAL */ {

			se (tabuleiroG[sub3Linha][sub3Coluna] == '0'){

				tabuleiroG[sub3Linha][sub3Coluna] = 'S'

				se (tabuleiroG[sub3Linha][sub3Coluna - 1] == '0') /* ATRIBUI O VALOR À CASA DA ESQUERDA CASO ESTEJA VAZIA */ {

					tabuleiroG[sub3Linha][sub3Coluna - 1] = 'S'
					
				} senao se (tabuleiroG[sub3Linha][sub3Coluna + 1] == '0') /* ATRIBUI O VALOR À CASA DA DIREITA CASO ESTEJA VAZIA */ {

					tabuleiroG[sub3Linha][sub3Coluna + 1] = 'S'
					
				} // EXISTE A POSSIBILIDADE DE NÃO HAVER CASAS DISPONÍVEIS NA HORIZONTAL, ENTÃO NESSE CASO FORÇAMOS UM SORTEIO PARA A VERTICAL.

				senao se (tabuleiroG[sub3Linha - 1][sub3Coluna] == '0'){ // CASA ACIMA

					tabuleiroG[sub3Linha - 1][sub3Coluna] = 'S'
					
				}

				senao se (tabuleiroG[sub3Linha + 1][sub3Coluna] == '0'){ // CASA ABAIXO

					tabuleiroG[sub3Linha + 1][sub3Coluna] = 'S'
					
				}
				
			}
			
		}

		senao se (direcao == 1) /* VERTICAL */ {

			se (tabuleiroG[sub3Linha][sub3Coluna] == '0'){

				tabuleiroG[sub3Linha][sub3Coluna] = 'S'

				se (tabuleiroG[sub3Linha - 1][sub3Coluna] == '0') /* ATRIBUI O VALOR À CASA ACIMA CASO ESTEJA VAZIA */ {

					tabuleiroG[sub3Linha - 1][sub3Coluna] = 'S'
					
				} senao se (tabuleiroG[sub3Linha + 1][sub3Coluna] == '0') /* ATRIBUI O VALOR À CASA ABAIXO CASO ESTEJA VAZIA */ {

					tabuleiroG[sub3Linha + 1][sub3Coluna] = 'S'
					
				} // EXISTE A POSSIBILIDADE DE NÃO HAVER CASAS DISPONÍVEIS NA VERTICAL, ENTÃO NESSE CASO FORÇAMOS UM SORTEIO PARA A HORIZONTAL.

				senao se (tabuleiroG[sub3Linha][sub3Coluna - 1] == '0'){ // CASA À ESQUERDA

					tabuleiroG[sub3Linha][sub3Coluna - 1] = 'S'
					
				}

				senao se (tabuleiroG[sub3Linha][sub3Coluna + 1] == '0'){ // CASA À DIREITA

					tabuleiroG[sub3Linha][sub3Coluna + 1] = 'S'
					
				}
				
			}
			
		}

		// ------------------------------------------------------------------------

		// SORTEAMOS OS DOIS PORTA-AVIÕES

		// --------- PORTA-AVIÃO 1 ----------

		// primeiro definimos a direção da embarcação.

		direcao = u.sorteia(0, 1) // 0 = horizontal; 1 = vertical

		faca {

			// excluí a possibilidade de sorteio de linhas e colunas que ficam no extremo do tabuleiro pois eu faço uma verificação de qualquer forma depois do sorteio.

			pa1Linha = u.sorteia(2, 7)
			pa1Coluna = u.sorteia(2, 7)
			
		} enquanto (tabuleiroG[pa1Linha][pa1Coluna] != '0')

		se (direcao == 0) /* HORIZONTAL */ {

			se (tabuleiroG[pa1Linha][pa1Coluna] == '0'){

				tabuleiroG[pa1Linha][pa1Coluna] = 'P'

				se (tabuleiroG[pa1Linha][pa1Coluna - 1] == '0') /* ATRIBUI O VALOR À CASA DA ESQUERDA CASO ESTEJA VAZIA */ {

					tabuleiroG[pa1Linha][pa1Coluna - 1] = 'P'

					se (tabuleiroG[pa1Linha][pa1Coluna - 2] == '0'){ /* CASO VAIZA, SEGUIMOS ADIANTE PARA A ESQUERDA, CASO CONTRARIO VAMOS PARA DIREITA */

						tabuleiroG[pa1Linha][pa1Coluna - 2] = 'P'
						
					} senao se (tabuleiroG[pa1Linha][pa1Coluna + 1] == '0'){

						tabuleiroG[pa1Linha][pa1Coluna + 1] = 'P'
						
					} // CASO NEM A ESQUERDA E NEM A DIREITA DESSE BLOCO DE DUAS CASAS JÁ PREVIAMENTE SORTEADAS ESTEJA DISPONÍVEL, VERIFICAMOS NA DIREÇÃO OPOSTA (NESSE CASO VERTICAL)
					
				} senao se (tabuleiroG[pa1Linha][pa1Coluna + 1] == '0') /* ATRIBUI O VALOR À CASA DA DIREITA CASO ESTEJA VAZIA */ {

					tabuleiroG[pa1Linha][pa1Coluna + 1] = 'P'

					se (tabuleiroG[pa1Linha][pa1Coluna + 2] == '0'){ /* CASO VAZIA, SEGUIMOS ADIANTE PARA A DIREITA, CASO CONTRARIO VAMOS PARA ESQUERDA */

						tabuleiroG[pa1Linha][pa1Coluna + 2] = 'P'
						
					} senao se (tabuleiroG[pa1Linha][pa1Coluna - 1] == '0'){

						tabuleiroG[pa1Linha][pa1Coluna - 1] = 'P'
						
					} // CASO NEM A ESQUERDA E NEM A DIREITA DESSE BLOCO DE DUAS CASAS JÁ PREVIAMENTE SORTEADAS ESTEJA DISPONÍVEL, VERIFICAMOS NA DIREÇÃO OPOSTA (NESSE CASO VERTICAL)
					
				} 
				
				// EXISTE A POSSIBILIDADE DE NÃO HAVER CASAS DISPONÍVEIS NA HORIZONTAL, ENTÃO NESSE CASO FORÇAMOS UM SORTEIO PARA A VERTICAL.

				senao se (tabuleiroG[pa1Linha - 1][pa1Coluna] == '0'){ // CASA ACIMA

					tabuleiroG[pa1Linha - 1][pa1Coluna] = 'S'

					se (tabuleiroG[pa1Linha - 2][pa1Coluna] == '0'){ /* CASO VAZIA, SEGUIMOS ADIANTE PARA CIMA, CASO CONTRARIO VAMOS PARA BAIXO */

						tabuleiroG[pa1Linha - 2][pa1Coluna] = 'P'
						
					} senao se (tabuleiroG[pa1Linha + 1][pa1Coluna] == '0'){

						tabuleiroG[pa1Linha + 1][pa1Coluna] = 'P'
						
					} // CASO NEM ACIMA E NEM ABAIXO DESSE BLOCO DE DUAS CASAS JÁ PREVIAMENTE SORTEADAS ESTEJA DISPONÍVEL, VERIFICAMOS NA DIREÇÃO OPOSTA (NESSE CASO HORIZONTAL)
					
				}

				senao se (tabuleiroG[pa1Linha + 1][pa1Coluna] == '0'){ // CASA ABAIXO

					tabuleiroG[pa1Linha + 1][pa1Coluna] = 'S'

					se (tabuleiroG[pa1Linha + 2][pa1Coluna] == '0'){ /* CASO VAZIA, SEGUIMOS ADIANTE PARA BAIXO, CASO CONTRARIO VAMOS PARA CIMA */

						tabuleiroG[pa1Linha + 2][pa1Coluna] = 'P'
						
					} senao se (tabuleiroG[pa1Linha - 1][pa1Coluna] == '0'){

						tabuleiroG[pa1Linha - 1][pa1Coluna] = 'P'
						
					} // CASO NEM ACIMA E NEM ABAIXO DESSE BLOCO DE DUAS CASAS JÁ PREVIAMENTE SORTEADAS ESTEJA DISPONÍVEL, VERIFICAMOS NA DIREÇÃO OPOSTA (NESSE CASO HORIZONTAL)
					
				}
				
			}
			
		}

		senao se (direcao == 1) /* VERTICAL */ {

			se (tabuleiroG[pa1Linha][pa1Coluna] == '0'){

				tabuleiroG[pa1Linha][pa1Coluna] = 'P'

				se (tabuleiroG[pa1Linha - 1][pa1Coluna] == '0') /* ATRIBUI O VALOR À CASA ACIMA CASO ESTEJA VAZIA */ {

					tabuleiroG[pa1Linha - 1][pa1Coluna] = 'P'

					se (tabuleiroG[pa1Linha - 2][pa1Coluna] == '0'){ /* CASO VAZIA, SEGUIMOS ADIANTE PARA CIMA, CASO CONTRARIO VAMOS PARA BAIXO */

						tabuleiroG[pa1Linha - 2][pa1Coluna] = 'P'
						
					} senao se (tabuleiroG[pa1Linha + 1][pa1Coluna] == '0'){

						tabuleiroG[pa1Linha + 1][pa1Coluna] = 'P'
						
					}
					
				} senao se (tabuleiroG[pa1Linha + 1][pa1Coluna] == '0') /* ATRIBUI O VALOR À CASA ABAIXO CASO ESTEJA VAZIA */ {

					tabuleiroG[pa1Linha + 1][pa1Coluna] = 'P'

					se (tabuleiroG[pa1Linha + 2][pa1Coluna] == '0'){ /* CASO VAZIA, SEGUIMOS ADIANTE PARA BAIXO, CASO CONTRARIO VAMOS PARA CIMA */

						tabuleiroG[pa1Linha + 2][pa1Coluna] = 'P'
						
					} senao se (tabuleiroG[pa1Linha - 1][pa1Coluna] == '0'){

						tabuleiroG[pa1Linha - 1][pa1Coluna] = 'P'
						
					}
					
				} // EXISTE A POSSIBILIDADE DE NÃO HAVER CASAS DISPONÍVEIS NA VERTICAL, ENTÃO NESSE CASO FORÇAMOS UM SORTEIO PARA A HORIZONTAL.

				senao se (tabuleiroG[pa1Linha][pa1Coluna - 1] == '0'){ // CASA À ESQUERDA

					tabuleiroG[pa1Linha][pa1Coluna - 1] = 'S'

					se (tabuleiroG[pa1Linha][pa1Coluna - 2] == '0'){ /* CASO VAZIA, SEGUIMOS ADIANTE PARA A ESQUERDA, CASO CONTRARIO VAMOS PARA DIREITA */

						tabuleiroG[pa1Linha][pa1Coluna - 2] = 'P'
						
					} senao se (tabuleiroG[pa1Linha][pa1Coluna + 1] == '0'){

						tabuleiroG[pa1Linha][pa1Coluna + 1] = 'P'
						
					}
					
				}

				senao se (tabuleiroG[pa1Linha][pa1Coluna + 1] == '0'){ // CASA À DIREITA

					tabuleiroG[pa1Linha][pa1Coluna + 1] = 'S'

					se (tabuleiroG[pa1Linha][pa1Coluna + 2] == '0'){ /* CASO VAZIA, SEGUIMOS ADIANTE PARA A DIREITA, CASO CONTRARIO VAMOS PARA ESQUERDA */

						tabuleiroG[pa1Linha][pa1Coluna + 2] = 'P'
						
					} senao se (tabuleiroG[pa1Linha][pa1Coluna - 1] == '0'){

						tabuleiroG[pa1Linha][pa1Coluna - 1] = 'P'
						
					}
					
				}
				
			}
			
		}

		// ----------------------------------------------------------------------------


		// --------- PORTA-AVIÃO 2 ----------

		// primeiro definimos a direção da embarcação.

		direcao = u.sorteia(0, 1) // 0 = horizontal; 1 = vertical

		faca {

			// excluí a possibilidade de sorteio de linhas e colunas que ficam no extremo do tabuleiro pois eu faço uma verificação de qualquer forma depois do sorteio.

			pa2Linha = u.sorteia(2, 7)
			pa2Coluna = u.sorteia(2, 7)
			
		} enquanto (tabuleiroG[pa2Linha][pa2Coluna] != '0')

		se (direcao == 0) /* HORIZONTAL */ {

			se (tabuleiroG[pa2Linha][pa2Coluna] == '0'){

				tabuleiroG[pa2Linha][pa2Coluna] = 'P'

				se (tabuleiroG[pa2Linha][pa2Coluna - 1] == '0') /* ATRIBUI O VALOR À CASA DA ESQUERDA CASO ESTEJA VAZIA */ {

					tabuleiroG[pa2Linha][pa2Coluna - 1] = 'P'

					se (tabuleiroG[pa2Linha][pa2Coluna - 2] == '0'){ /* CASO VAIZA, SEGUIMOS ADIANTE PARA A ESQUERDA, CASO CONTRARIO VAMOS PARA DIREITA */

						tabuleiroG[pa2Linha][pa2Coluna - 2] = 'P'
						
					} senao se (tabuleiroG[pa2Linha][pa2Coluna + 1] == '0'){

						tabuleiroG[pa2Linha][pa2Coluna + 1] = 'P'
						
					} // CASO NEM A ESQUERDA E NEM A DIREITA DESSE BLOCO DE DUAS CASAS JÁ PREVIAMENTE SORTEADAS ESTEJA DISPONÍVEL, VERIFICAMOS NA DIREÇÃO OPOSTA (NESSE CASO VERTICAL)
					
				} senao se (tabuleiroG[pa2Linha][pa2Coluna + 1] == '0') /* ATRIBUI O VALOR À CASA DA DIREITA CASO ESTEJA VAZIA */ {

					tabuleiroG[pa2Linha][pa2Coluna + 1] = 'P'

					se (tabuleiroG[pa2Linha][pa2Coluna + 2] == '0'){ /* CASO VAZIA, SEGUIMOS ADIANTE PARA A DIREITA, CASO CONTRARIO VAMOS PARA ESQUERDA */

						tabuleiroG[pa2Linha][pa2Coluna + 2] = 'P'
						
					} senao se (tabuleiroG[pa2Linha][pa2Coluna - 1] == '0'){

						tabuleiroG[pa2Linha][pa2Coluna - 1] = 'P'
						
					} // CASO NEM A ESQUERDA E NEM A DIREITA DESSE BLOCO DE DUAS CASAS JÁ PREVIAMENTE SORTEADAS ESTEJA DISPONÍVEL, VERIFICAMOS NA DIREÇÃO OPOSTA (NESSE CASO VERTICAL)
					
				} 
				
				// EXISTE A POSSIBILIDADE DE NÃO HAVER CASAS DISPONÍVEIS NA HORIZONTAL, ENTÃO NESSE CASO FORÇAMOS UM SORTEIO PARA A VERTICAL.

				senao se (tabuleiroG[pa2Linha - 1][pa2Coluna] == '0'){ // CASA ACIMA

					tabuleiroG[pa2Linha - 1][pa2Coluna] = 'S'

					se (tabuleiroG[pa2Linha - 2][pa2Coluna] == '0'){ /* CASO VAZIA, SEGUIMOS ADIANTE PARA CIMA, CASO CONTRARIO VAMOS PARA BAIXO */

						tabuleiroG[pa2Linha - 2][pa2Coluna] = 'P'
						
					} senao se (tabuleiroG[pa2Linha + 1][pa2Coluna] == '0'){

						tabuleiroG[pa2Linha + 1][pa2Coluna] = 'P'
						
					} // CASO NEM ACIMA E NEM ABAIXO DESSE BLOCO DE DUAS CASAS JÁ PREVIAMENTE SORTEADAS ESTEJA DISPONÍVEL, VERIFICAMOS NA DIREÇÃO OPOSTA (NESSE CASO HORIZONTAL)
					
				}

				senao se (tabuleiroG[pa2Linha + 1][pa2Coluna] == '0'){ // CASA ABAIXO

					tabuleiroG[pa2Linha + 1][pa2Coluna] = 'S'

					se (tabuleiroG[pa2Linha + 2][pa2Coluna] == '0'){ /* CASO VAZIA, SEGUIMOS ADIANTE PARA BAIXO, CASO CONTRARIO VAMOS PARA CIMA */

						tabuleiroG[pa2Linha + 2][pa2Coluna] = 'P'
						
					} senao se (tabuleiroG[pa2Linha - 1][pa2Coluna] == '0'){

						tabuleiroG[pa2Linha - 1][pa2Coluna] = 'P'
						
					} // CASO NEM ACIMA E NEM ABAIXO DESSE BLOCO DE DUAS CASAS JÁ PREVIAMENTE SORTEADAS ESTEJA DISPONÍVEL, VERIFICAMOS NA DIREÇÃO OPOSTA (NESSE CASO HORIZONTAL)
					
				}
				
			}
			
		}

		senao se (direcao == 1) /* VERTICAL */ {

			se (tabuleiroG[pa2Linha][pa2Coluna] == '0'){

				tabuleiroG[pa2Linha][pa2Coluna] = 'P'

				se (tabuleiroG[pa2Linha - 1][pa2Coluna] == '0') /* ATRIBUI O VALOR À CASA ACIMA CASO ESTEJA VAZIA */ {

					tabuleiroG[pa2Linha - 1][pa2Coluna] = 'P'

					se (tabuleiroG[pa2Linha - 2][pa2Coluna] == '0'){ /* CASO VAZIA, SEGUIMOS ADIANTE PARA CIMA, CASO CONTRARIO VAMOS PARA BAIXO */

						tabuleiroG[pa2Linha - 2][pa2Coluna] = 'P'
						
					} senao se (tabuleiroG[pa2Linha + 1][pa2Coluna] == '0'){

						tabuleiroG[pa2Linha + 1][pa2Coluna] = 'P'
						
					}
					
				} senao se (tabuleiroG[pa2Linha + 1][pa2Coluna] == '0') /* ATRIBUI O VALOR À CASA ABAIXO CASO ESTEJA VAZIA */ {

					tabuleiroG[pa2Linha + 1][pa2Coluna] = 'P'

					se (tabuleiroG[pa2Linha + 2][pa2Coluna] == '0'){ /* CASO VAZIA, SEGUIMOS ADIANTE PARA BAIXO, CASO CONTRARIO VAMOS PARA CIMA */

						tabuleiroG[pa2Linha + 2][pa2Coluna] = 'P'
						
					} senao se (tabuleiroG[pa2Linha - 1][pa2Coluna] == '0'){

						tabuleiroG[pa2Linha - 1][pa2Coluna] = 'P'
						
					}
					
				} // EXISTE A POSSIBILIDADE DE NÃO HAVER CASAS DISPONÍVEIS NA VERTICAL, ENTÃO NESSE CASO FORÇAMOS UM SORTEIO PARA A HORIZONTAL.

				senao se (tabuleiroG[pa2Linha][pa2Coluna - 1] == '0'){ // CASA À ESQUERDA

					tabuleiroG[pa2Linha][pa2Coluna - 1] = 'S'

					se (tabuleiroG[pa2Linha][pa2Coluna - 2] == '0'){ /* CASO VAZIA, SEGUIMOS ADIANTE PARA A ESQUERDA, CASO CONTRARIO VAMOS PARA DIREITA */

						tabuleiroG[pa2Linha][pa2Coluna - 2] = 'P'
						
					} senao se (tabuleiroG[pa2Linha][pa2Coluna + 1] == '0'){

						tabuleiroG[pa2Linha][pa2Coluna + 1] = 'P'
						
					}
					
				}

				senao se (tabuleiroG[pa2Linha][pa2Coluna + 1] == '0'){ // CASA À DIREITA

					tabuleiroG[pa2Linha][pa2Coluna + 1] = 'S'

					se (tabuleiroG[pa2Linha][pa2Coluna + 2] == '0'){ /* CASO VAZIA, SEGUIMOS ADIANTE PARA A DIREITA, CASO CONTRARIO VAMOS PARA ESQUERDA */

						tabuleiroG[pa2Linha][pa2Coluna + 2] = 'P'
						
					} senao se (tabuleiroG[pa2Linha][pa2Coluna - 1] == '0'){

						tabuleiroG[pa2Linha][pa2Coluna - 1] = 'P'
						
					}
					
				}
				
			}
			
		}

		// ----------------------------------------------------------------------------


		// --------- PORTA-AVIÃO 2 ----------
		

		// primeiro definimos a direção da embarcação.

		direcao = u.sorteia(0, 1) // 0 = horizontal; 1 = vertical

		faca {

			// excluí a possibilidade de sorteio de linhas e colunas que ficam no extremo do tabuleiro pois eu faço uma verificação de qualquer forma depois do sorteio.

			pa3Linha = u.sorteia(2, 7)
			pa3Coluna = u.sorteia(2, 7)
			
		} enquanto (tabuleiroG[pa3Linha][pa3Coluna] != '0')

		se (direcao == 0) /* HORIZONTAL */ {

			se (tabuleiroG[pa3Linha][pa3Coluna] == '0'){

				tabuleiroG[pa3Linha][pa3Coluna] = 'P'

				se (tabuleiroG[pa3Linha][pa3Coluna - 1] == '0') /* ATRIBUI O VALOR À CASA DA ESQUERDA CASO ESTEJA VAZIA */ {

					tabuleiroG[pa3Linha][pa3Coluna - 1] = 'P'

					se (tabuleiroG[pa3Linha][pa3Coluna - 2] == '0'){ /* CASO VAIZA, SEGUIMOS ADIANTE PARA A ESQUERDA, CASO CONTRARIO VAMOS PARA DIREITA */

						tabuleiroG[pa3Linha][pa3Coluna - 2] = 'P'
						
					} senao se (tabuleiroG[pa3Linha][pa3Coluna + 1] == '0'){

						tabuleiroG[pa3Linha][pa3Coluna + 1] = 'P'
						
					} // CASO NEM A ESQUERDA E NEM A DIREITA DESSE BLOCO DE DUAS CASAS JÁ PREVIAMENTE SORTEADAS ESTEJA DISPONÍVEL, VERIFICAMOS NA DIREÇÃO OPOSTA (NESSE CASO VERTICAL)
					
				} senao se (tabuleiroG[pa3Linha][pa3Coluna + 1] == '0') /* ATRIBUI O VALOR À CASA DA DIREITA CASO ESTEJA VAZIA */ {

					tabuleiroG[pa3Linha][pa3Coluna + 1] = 'P'

					se (tabuleiroG[pa3Linha][pa3Coluna + 2] == '0'){ /* CASO VAZIA, SEGUIMOS ADIANTE PARA A DIREITA, CASO CONTRARIO VAMOS PARA ESQUERDA */

						tabuleiroG[pa3Linha][pa3Coluna + 2] = 'P'
						
					} senao se (tabuleiroG[pa3Linha][pa3Coluna - 1] == '0'){

						tabuleiroG[pa3Linha][pa3Coluna - 1] = 'P'
						
					} // CASO NEM A ESQUERDA E NEM A DIREITA DESSE BLOCO DE DUAS CASAS JÁ PREVIAMENTE SORTEADAS ESTEJA DISPONÍVEL, VERIFICAMOS NA DIREÇÃO OPOSTA (NESSE CASO VERTICAL)
					
				} 
				
				// EXISTE A POSSIBILIDADE DE NÃO HAVER CASAS DISPONÍVEIS NA HORIZONTAL, ENTÃO NESSE CASO FORÇAMOS UM SORTEIO PARA A VERTICAL.

				senao se (tabuleiroG[pa3Linha - 1][pa3Coluna] == '0'){ // CASA ACIMA

					tabuleiroG[pa3Linha - 1][pa3Coluna] = 'S'

					se (tabuleiroG[pa3Linha - 2][pa3Coluna] == '0'){ /* CASO VAZIA, SEGUIMOS ADIANTE PARA CIMA, CASO CONTRARIO VAMOS PARA BAIXO */

						tabuleiroG[pa3Linha - 2][pa3Coluna] = 'P'
						
					} senao se (tabuleiroG[pa3Linha + 1][pa3Coluna] == '0'){

						tabuleiroG[pa3Linha + 1][pa3Coluna] = 'P'
						
					} // CASO NEM ACIMA E NEM ABAIXO DESSE BLOCO DE DUAS CASAS JÁ PREVIAMENTE SORTEADAS ESTEJA DISPONÍVEL, VERIFICAMOS NA DIREÇÃO OPOSTA (NESSE CASO HORIZONTAL)
					
				}

				senao se (tabuleiroG[pa3Linha + 1][pa3Coluna] == '0'){ // CASA ABAIXO

					tabuleiroG[pa3Linha + 1][pa3Coluna] = 'S'

					se (tabuleiroG[pa3Linha + 2][pa3Coluna] == '0'){ /* CASO VAZIA, SEGUIMOS ADIANTE PARA BAIXO, CASO CONTRARIO VAMOS PARA CIMA */

						tabuleiroG[pa3Linha + 2][pa3Coluna] = 'P'
						
					} senao se (tabuleiroG[pa3Linha - 1][pa3Coluna] == '0'){

						tabuleiroG[pa3Linha - 1][pa3Coluna] = 'P'
						
					} // CASO NEM ACIMA E NEM ABAIXO DESSE BLOCO DE DUAS CASAS JÁ PREVIAMENTE SORTEADAS ESTEJA DISPONÍVEL, VERIFICAMOS NA DIREÇÃO OPOSTA (NESSE CASO HORIZONTAL)
					
				}
				
			}
			
		}

		senao se (direcao == 1) /* VERTICAL */ {

			se (tabuleiroG[pa3Linha][pa3Coluna] == '0'){

				tabuleiroG[pa3Linha][pa3Coluna] = 'P'

				se (tabuleiroG[pa3Linha - 1][pa3Coluna] == '0') /* ATRIBUI O VALOR À CASA ACIMA CASO ESTEJA VAZIA */ {

					tabuleiroG[pa3Linha - 1][pa3Coluna] = 'P'

					se (tabuleiroG[pa3Linha - 2][pa3Coluna] == '0'){ /* CASO VAZIA, SEGUIMOS ADIANTE PARA CIMA, CASO CONTRARIO VAMOS PARA BAIXO */

						tabuleiroG[pa3Linha - 2][pa3Coluna] = 'P'
						
					} senao se (tabuleiroG[pa3Linha + 1][pa3Coluna] == '0'){

						tabuleiroG[pa3Linha + 1][pa3Coluna] = 'P'
						
					}
					
				} senao se (tabuleiroG[pa3Linha + 1][pa3Coluna] == '0') /* ATRIBUI O VALOR À CASA ABAIXO CASO ESTEJA VAZIA */ {

					tabuleiroG[pa3Linha + 1][pa3Coluna] = 'P'

					se (tabuleiroG[pa3Linha + 2][pa3Coluna] == '0'){ /* CASO VAZIA, SEGUIMOS ADIANTE PARA BAIXO, CASO CONTRARIO VAMOS PARA CIMA */

						tabuleiroG[pa3Linha + 2][pa3Coluna] = 'P'
						
					} senao se (tabuleiroG[pa3Linha - 1][pa3Coluna] == '0'){

						tabuleiroG[pa3Linha - 1][pa3Coluna] = 'P'
						
					}
					
				} // EXISTE A POSSIBILIDADE DE NÃO HAVER CASAS DISPONÍVEIS NA VERTICAL, ENTÃO NESSE CASO FORÇAMOS UM SORTEIO PARA A HORIZONTAL.

				senao se (tabuleiroG[pa3Linha][pa3Coluna - 1] == '0'){ // CASA À ESQUERDA

					tabuleiroG[pa3Linha][pa3Coluna - 1] = 'S'

					se (tabuleiroG[pa3Linha][pa3Coluna - 2] == '0'){ /* CASO VAZIA, SEGUIMOS ADIANTE PARA A ESQUERDA, CASO CONTRARIO VAMOS PARA DIREITA */

						tabuleiroG[pa3Linha][pa3Coluna - 2] = 'P'
						
					} senao se (tabuleiroG[pa3Linha][pa3Coluna + 1] == '0'){

						tabuleiroG[pa3Linha][pa3Coluna + 1] = 'P'
						
					}
					
				}

				senao se (tabuleiroG[pa3Linha][pa3Coluna + 1] == '0'){ // CASA À DIREITA

					tabuleiroG[pa3Linha][pa3Coluna + 1] = 'S'

					se (tabuleiroG[pa3Linha][pa3Coluna + 2] == '0'){ /* CASO VAZIA, SEGUIMOS ADIANTE PARA A DIREITA, CASO CONTRARIO VAMOS PARA ESQUERDA */

						tabuleiroG[pa3Linha][pa3Coluna + 2] = 'P'
						
					} senao se (tabuleiroG[pa3Linha][pa3Coluna - 1] == '0'){

						tabuleiroG[pa3Linha][pa3Coluna - 1] = 'P'
						
					}
					
				}
				
			}
			
		}
 	
   }
}
/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 13112; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */
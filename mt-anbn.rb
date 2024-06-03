module MtAnBn
  # Estados codificados
  q0 = "fa"        # Estado inicial
  q1 = "faa"       # Estado de transição
  q2 = "faaa"      # Outro estado de transição
  q3 = "faaaa"     # Outro estado de transição
  q4 = "faab"      # Outro estado de transição
  q5 = "fb"        # Estado de aceitação

  # Símbolos na fita
  @a = "sc"        # Símbolo 'a'
  @x = "scc"       # Símbolo marcado 'x'
  @b = "sccc"      # Símbolo 'b'
  @y = "scccc"     # Símbolo marcado 'y'
  @blank = "_"     # Símbolo em branco

  # Movimentos
  left = "e"       # Esquerda
  right = "d"      # Direita

  # Transições para a linguagem a^nb^n
  @transition1 = "#{q0}#{@a}#{q1}#{@x}#{right}"    # (q0, a) -> (q1, x, D)
  @transition2 = "#{q1}#{@a}#{q1}#{@a}#{right}"    # (q1, a) -> (q1, a, D)
  @transition3 = "#{q1}#{@b}#{q2}#{@y}#{left}"     # (q1, b) -> (q2, y, E)
  @transition4 = "#{q2}#{@a}#{q2}#{@a}#{left}"     # (q2, a) -> (q2, a, E)
  @transition5 = "#{q2}#{@x}#{q0}#{@x}#{right}"    # (q2, x) -> (q0, x, D)
  @transition6 = "#{q0}#{@y}#{q0}#{@y}#{right}"    # (q0, y) -> (q0, y, D)
  @transition7 = "#{q0}#{@blank}#{q5}#{@blank}#{right}"  # (q0, _) -> (q5, _, D)

  # Método para concatenar todas as transições em uma única string
  def self.linker
    "#{@transition1}#{@transition2}#{@transition3}#{@transition4}#{@transition5}#{@transition6}#{@transition7}"
  end

  # Método para retornar a codificação da cadeia inicial aabb
  def self.codificacao_palavra
    "#{@a}#{@a}#{@b}#{@b}"
  end
end
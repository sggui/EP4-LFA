class TuringMachine
  attr_accessor :states, :alphabet, :tape_alphabet, :transitions, :initial_state, :accept_states, :reject_states, :tape, :head_position, :current_state

  # Inicializa a máquina de Turing com os estados, alfabetos, transições, estado inicial, estados de aceitação e rejeição, fita, posição da cabeça e estado atual
  def initialize(states, alphabet, tape_alphabet, transitions, initial_state, accept_states, reject_states, tape, head_position, current_state)
    @states = states
    @alphabet = alphabet
    @tape_alphabet = tape_alphabet
    @transitions = transitions
    @initial_state = initial_state
    @accept_states = accept_states
    @reject_states = reject_states
    @tape = tape
    @head_position = head_position
    @current_state = current_state
  end

  # Executa um passo da máquina de Turing
  def step
    current_symbol = @tape[@head_position]
    action = @transitions[[@current_state, current_symbol]]
    if action.nil?
      puts "No transition found for state #{@current_state} and symbol #{current_symbol}"
      @current_state = @reject_states.first
      return false
    end
    puts "Step: #{@current_state}, #{current_symbol} -> #{action[:write]}, #{action[:move]}, #{action[:next_state]}"
    @tape[@head_position] = action[:write]
    @head_position += (action[:move] == 'd' ? 1 : -1)
    @current_state = action[:next_state]
    true
  end

  # Executa a máquina até que ela chegue a um estado de aceitação ou rejeição
  def run
    until @accept_states.include?(@current_state) || @reject_states.include?(@current_state)
      break unless step
    end
    @accept_states.include?(@current_state)
  end

  # Executa a máquina em modo de depuração, imprimindo cada passo
  def debug_run
    steps = 0
    until @accept_states.include?(@current_state) || @reject_states.include?(@current_state)
      puts "Step #{steps}:"
      puts "  Tape: #{@tape.join}"
      puts "  Head Position: #{@head_position}"
      puts "  Current State: #{@current_state}"
      break unless step
      steps += 1
    end
    puts "Final State: #{@current_state}"
    puts "Final Tape: #{@tape.join}"
    @accept_states.include?(@current_state)
  end
end

# Carrega a máquina de Turing a partir de um arquivo
def load_tm_from_file(file_path)
  file_content = File.read(file_path).strip
  lines = file_content.split("\n")

  # Lê os estados, alfabetos, estado inicial, estados de aceitação e rejeição
  states = lines[0].split(',')
  alphabet = lines[1].split(',')
  tape_alphabet = lines[2].split(',')
  initial_state = lines[3]
  accept_states = lines[4].split(',')
  reject_states = lines[5].split(',')
  transitions = {}

  # Lê as transições
  lines[6..-1].each do |line|
    parts = line.split(' ')
    state = parts[0]
    symbol = parts[1]
    write = parts[2]
    move = parts[3]
    next_state = parts[4]
    transitions[[state, symbol]] = { write: write, move: move, next_state: next_state }
  end

  [states, alphabet, tape_alphabet, transitions, initial_state, accept_states, reject_states]
end

# Executa um teste da máquina de Turing a partir de um arquivo e uma fita inicial
def run_test(file_path, initial_tape)
  states, alphabet, tape_alphabet, transitions, initial_state, accept_states, reject_states = load_tm_from_file(file_path)
  initial_head_position = 0

  # Transforma a string da fita inicial em um array de símbolos
  tape = initial_tape.scan(/sc|scc|sccc|_/)

  tm = TuringMachine.new(states, alphabet, tape_alphabet, transitions, initial_state, accept_states, reject_states, tape, initial_head_position, initial_state)
  result = tm.debug_run

  puts result ? 'Accepted' : 'Rejected'
end

# Função para imprimir os passos do teste
def print_steps_for_test(file_path, initial_tape)
  puts "Running test for file: #{file_path} with initial tape: #{initial_tape}"
  run_test(file_path, initial_tape)
  puts "\n\n"
end

# Executa os testes

# Teste para a Linguagem Livre de Contexto (a^n b^n)
print_steps_for_test('cfg_anbn.txt', 'scscsccscc') # Exemplo de entrada: aabb

# Teste para a Linguagem Sensível ao Contexto (a^n b^n c^n)
print_steps_for_test('csg_ancbncn.txt', 'scscsccsccsccc') # Exemplo de entrada: aabbcc

# Teste para a multiplicação (a * b = c)
print_steps_for_test('multiply.txt', 'scscsccscc') # Exemplo de entrada: aaabb (3*2=6) -> cccccc

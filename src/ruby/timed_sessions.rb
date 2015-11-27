require 'yaml'

class TimedSession

  def start(name)
    data = get_data name
    if can_start?(data[current_session_key])
      start_session data
    else
      puts 'current session not stopped'
    end
    save_data data, name
  end

  def break(name)
    data = get_data name
    session = data[current_session_key]
    session.nil? ? puts('No session started') : session_break(session)
    save_data data, name
  end

  def stop(name)
    data = get_data name
    if cannot_stop?(data[current_session_key])
      puts 'current session not started'
    else
      add_stop_time data[current_session_key]
    end
    save_data data, name
  end

  def print(name)
    puts get_data(name)
  end

  def get_data(name)
    get_save_file name
  end

  private

  def start_session(data)
    rename_old_session data
    data[current_session_key] = {}
    add_start_time data[current_session_key]
  end

  def session_break(session)
    session[breaks_key] = [] if session[breaks_key].nil?
    break_data = session[breaks_key].last
    if can_start?(break_data)
      break_data = {}
      add_start_time break_data
      session[breaks_key] << break_data
    else
      add_stop_time break_data
    end
  end

  def session_file(name)
    root = File.expand_path "~/.timed_sessions/#{name}.yaml"
  end

  def rename_old_session(data)
    new_name = "session_#{data.keys.size}"
    data[new_name] = data[current_session_key] if data[current_session_key]
  end

  def save_data(data, name)
    File.open(session_file(name), 'w+') { |file| file.write data.to_yaml }
  end

  def get_save_file(name)
    file = session_file name
    ensure_directory_exists file
    File.exists?(file) ? YAML.load_file(file) : {}
  end

  def ensure_directory_exists(path)
    dirname = File.dirname path
    FileUtils.mkdir_p(dirname) unless File.directory?(dirname)
  end

  def cannot_stop?(hash)
    hash.nil? || hash[start_key].nil?
  end

  def can_start?(hash)
    hash.nil? || !hash[stop_key].nil?
  end

  def add_start_time(hash)
    hash[start_key] = Time.now
  end

  def add_stop_time(hash)
    hash[stop_key] = Time.now if hash[start_key]
  end

  def current_session_key
    'current_session'
  end

  def breaks_key
    'breaks'
  end

  def stop_key
    'stop'
  end

  def start_key
    'start'
  end
end

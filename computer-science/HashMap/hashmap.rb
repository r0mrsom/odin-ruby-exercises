class HashMap

  attr_accessor :load_factor, :capacity, :hash_map, :size

  def initialize(load_factor = 0.75, capacity = 16)
    @load_factor = load_factor
    @capacity = capacity
    @hash_map = Array.new(capacity)
    @size = 0
  end

  def hash(key)
    hash_code = 0
    prime_number = 31
        
    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }
        
    hash_code
  end
 
  def set(key, value)
    added_new_key = insert_data(key, value)

    self.size += 1 if added_new_key

    grow if !load_factor_ok?
  end

  def get(key)
    remainder = remainder(key)
    return nil if !has?(key) || self.hash_map[remainder].nil?

    self.hash_map[remainder].find do |elements|
      return elements[1] if key == elements[0]
    end
  end

  def has?(key)
    remainder = remainder(key)
    return false if self.hash_map[remainder].nil?

    self.hash_map[remainder].any? { |elements| elements[0] == key }
  end

  def remove(key)
    remainder = remainder(key)
    bucket = self.hash_map[remainder]
    return nil if bucket.nil?

    pair_index = bucket.index { |pair| pair[0] == key }
    return nill if pair_index.nil?
    
    removed_pair = bucket.delete_at(pair_index)
    hash_map[remainder] = nil if bucket.empty?

    self.size -= 1
    removed_pair[1]
  end

  def length
    self.size
  end

  def clear
    self.hash_map = Array.new(capacity)
    self.size = 0
  end

  def keys
    return nil if self.hash_map.nil?
    result = []

    self.hash_map.each do |elements|
      if !elements.nil?
        elements.each do |subelements|
          if !subelements.nil?
            result << subelements[0]
          end
        end
      end
    end
    
    result
  end

  def values
    return nil if self.hash_map.nil?
    result = []

    self.hash_map.each do |elements|
      if !elements.nil?
        elements.each do |subelements|
          if !subelements.nil?
            result << subelements[1]
          end
        end
      end
    end
    result
  end

  def entries
    return nil if self.hash_map.nil?
    result = []

    self.hash_map.each do |elements|
      if !elements.nil?
        elements.each do |subelements|
          if !subelements.nil?
            result << subelements
          end
        end
      end
    end
    result
  end

  def remainder(key)
    hash(key) % capacity
  end

  def to_s
    self.hash_map.each do |elements|
      p elements
    end
  end

  def load_factor_ok?
    length / self.capacity.to_f > self.load_factor ? false : true
  end

  def insert_data(key, value)
    remainder = hash(key) % self.capacity
    self.hash_map[remainder] ||= []

    bucket = self.hash_map[remainder]
    existing_pair = bucket.find { |pair| pair[0] == key}

    if existing_pair
      existing_pair[1] = value
      return false
    else
      bucket << [key, value]
      return true
    end
  end

  def grow
    self.capacity = self.capacity * 2
    old_hash = entries
    self.hash_map = Array.new(self.capacity)
    
    old_hash.each do |key, value|
      insert_data(key, value)
    end
  end

end
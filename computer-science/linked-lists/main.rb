class LinkedList
    
    def initialize
        @head = nil
    end

    def append(value)
        #Check if Linked List doesn't exists. We create new node if it does not exist
        if @head.nil?
            @head = Node.new(value)

        #If LinkedList exists
        else
            current = @head
            #we iterate until we reach the last element
            while current.next_node!= nil
                current = current.next_node
            end
        #We assign the last element's next node a new Node
        current.next_node = Node.new(value)
        end
    end

    def prepend(value)
        #Check if Linked List doesn't exists. We create new node if it does not exist
        if @head.nil?
            @head = Node.new(value)
        
        #If LinkedList exists
        else
            current = @head
            #We assign an new node, assigning the value, and next node is assigned to the current head
            @head = Node.new(value, current)
        end
    end

    def size
        #Check if Linked List doesn't exist. return 0 it it is satisfied
        if @head.nil?
          0
        #We iterate through the nodes, then return the count
        else
            i = 1
            current = @head
            while current.next_node != nil
              i += 1
              current = current.next_node
            end
            i
        end
    end

    def head
        #Check if Linked List doesn't exist. return nil if it is satisfied.
        if @head.nil?
            nil
        #Return the value element of the head
        else
            @head.value
        end
    end

    def tail
        #Check if Linked List doesn't exist. return nil if it is satisfied.
        if @head.nil?
            nil
        #We iterate through all the nodes. then return its satisfied.
        else
            current = @head
            while current.next_node != nil
              current = current.next_node
            end
            current.value
        end
    end

    def at(index)
        #Check if Linked List doesn't exist. return nil if it is satisfied.
        if @head.nil?
            nil
        else
        #We iterate through all the index until we reach that index. then return its value.
            return @head.value if index == 0
            i = 0
            current = @head
            while i < index && current.next_node != nil
              current = current.next_node
              i += 1
            end
            return current.value if i == index
            #Return nil index is more than the nodes of the Linked List
            nil
        end
    end

    def pop
        #Check if Linked List doesn't exist. return nil if it is satisfied.
        if @head.nil?
            nil

        #We assign the head to the next node, then return the removed node
        else
            current = @head
            @head = current.next_node
            current.value
        end
    end

    def contains?(value)
        #Check if Linked List doesn't exist. return false if it is satisfied.
        if @head.nil?
            false
        #This iterates through the notes until it equals the value that we are trying to find
        else
            current = @head
            while current.next_node != nil && current.value != value
                current = current.next_node
            end
            return true if current.value == value
            #Return false if all are searched but no value is equal
            false
        end
    end

    def index(value)
        #Check if Linked List doesn't exist. return nil if it is satisfied.
        if @head.nil?
            nil
        #This iterates through the notes until it equals the value that we are trying to find, then we count the iterations
        else
            i = 0
            current = @head
            while current.next_node != nil && current.value != value
                current = current.next_node
                i += 1
            end
            return i if current.value == value
            #Return nil if all are searched but no value is equal
            nil
        end
    end

    def to_s
        #Check if Linked List doesn't exist. return empty string if it is satisfied.
        return if @head.nil?

        #We iterate through all the nodes, then print them
        display = ""
        current = @head
        while current.next_node != nil
            display += "( #{current.value} ) -> "
            current = current.next_node
        end

        #Once we reach the last node, print its value, then print nil
        display += "( #{current.value} ) -> nil"
        display
    end

    #BONUS ACTIVITIES
    def insert_at(index, *value)
        #Check if LinkedList exists
        if @head.nil?
            #Insertion will only append at empty LinkedList if index is 0
            if index == 0 && !value.empty?
                for elements in value
                    append(elements)
                end
            else
                raise "IndexError"
            end
        #This code executes if value is not empty and index is within the existing linked list
        elsif index <= size && !value.empty?
            #New head is created, We will be appending it one by one with the current linked list and the values we wish to append
            new_head = nil
            new_current = nil
            current = @head

            #Variables for while loop iteration
            index_counter = 0
            index_range = [index, index + value.length - 1]
            value_counter = 0

            #This will iterate through the NEW total length of linked list
            while index_counter < value.length + size
                #This executes only if the index counter is within the range of the value's new index. We iterate through the value to append, then append it to the new head
                if index_counter.between?(index_range[0], index_range[1])
                    if index_counter == 0
                        new_head = Node.new(value[value_counter])
                        new_current = new_head
                    else
                        new_current.next_node = Node.new(value[value_counter])
                        new_current = new_current.next_node
                    end
                    value_counter += 1
                #This executes only if the index counter is not within the range of the value's new idex. We iterate through the current linked list then append it to the new head.
                else
                    if index_counter == 0
                        new_head = Node.new(current.value)
                        new_current = new_head
                    else
                        new_current.next_node = Node.new(current.value)
                        new_current = new_current.next_node
                    end
                    current = current.next_node
                end
                #Once one iteration is done, we move the the next index of the new head
                index_counter += 1
            end
            
            #We assign the new head to the head itself
            @head = new_head
        
        else
            raise "IndexError"
        end
    end

    #another BONUS activity
    def remove_at(index)
        #Check if LinkedList exists or check if index is within the range of the existing LinkedList
        if @head.nil? || index >= size || index < 0
            raise "IndexError" 
        else
            #Variables for iteration
            current = @head
            index_counter = 0
            #Perform pop if index is zero
            if index == 0
                pop
            #This is performed if index is more than 1
            else
                #We continuously move to the next node until we reach the index - 1 (NOTE: we wish to access the previous index of the identified)
                while index_counter < index - 1
                    index_counter += 1
                    current = current.next_node
                end

                #if the index is the end of the element, we assign the second to the last's next node to nil
                if index == size - 1
                    current.next_node = nil
                #if previous criteria is not met, the previous node's next node will initiate a new Node, assigning it to the index's next value and next - next node
                else
                    current.next_node = Node.new(current.next_node.next_node.value, current.next_node.next_node.next_node)
                end
            end
        end
    end

end

class Node
    attr_accessor :value, :next_node

    def initialize(value = nil, next_node = nil)
        @value = value
        @next_node = next_node
    end
end

#CODE TESTING HERE

list = LinkedList.new

list.append('dog')
list.append('cat')
list.append('parrot')
list.append('hamster')
list.append('snake')
list.append('turtle')

list.prepend("alien")

puts list.to_s
puts list.size
puts list.head
puts list.tail
puts list.at(4)

puts list.pop
puts list.to_s

puts list.contains?("dog")
puts list.contains?("cat")
puts list.contains?("mushroom")

p list.index("turtle")
p list.index("mushroom")

list.insert_at(0, "mice", "elephant")
puts list.to_s
list.insert_at(2, "kangaroo", "zebra")
puts list.to_s
list.insert_at(10, "giraffe", "lion")
puts list.to_s

#This will give IndexError
#list.insert_at(13, 1, 5)

new_list = LinkedList.new
#This will give IndexError as well
#new_list.insert_at(1, "giraffe")
new_list.insert_at(0, "giraffe", "elephant")
puts new_list.to_s

new_list.remove_at(1)
puts new_list.to_s
#These will give IndexError
#new_list.remove_at(10)
#LinkedList.new.remove_at(0)


class Todo
  @todo_list = []

  def self.list
    @todo_list
  end

  def self.edit(&block)
    class_eval(&block)
  end

  def self.method_missing(task_name)
    if task_name[-1..-1] == "!" and @todo_list.include? task_name[0...-1].to_sym
      @todo_list.delete task_name[0...-1]
    else
      @todo_list << task_name unless @todo_list.include? task_name
    end
  end
end

Todo.walk_dog
Todo.take_out_trash

Todo.edit do
  take_out_trash!
  buy_groceries
end

p Todo.list

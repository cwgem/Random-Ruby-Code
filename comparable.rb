require 'pp'

class Employee
  attr_accessor :first_name
  attr_accessor :last_name
  attr_accessor :monthly_sales
  
  include Comparable
  # 月間売上高で社員をソート
  def <=>(other_employee)
    other_employee.monthly_sales <=> @monthly_sales
  end
  
  def to_s
    "#{@first_name} #{@last_name}: #{@monthly_sales}"
  end
end

# ランダム数　最小-最大
def range_rand(min,max)
  min + rand(max-min)
end

def accept_var(*args)
  puts args.inspect
end

# ランダム名前
$names = File.new('names.txt', 'r').readlines.map {|line| line.chomp}
def rand_name
  $names[rand($names.length)]
end

# ランダムデータで社員3人作ります
employees = Array.new(3) { |index|
  employee = Employee.new
  employee.first_name = rand_name
  employee.last_name = rand_name
  employee.monthly_sales = range_rand(1000,10000)
  employee
}

pp employees.sort

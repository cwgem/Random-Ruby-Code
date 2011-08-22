require "test/unit"
require "./object_describe"

class TestClass
  @@my_class_var = "hello"
  attr_accessor :my_inst_var

  def initialize(myvar)
    @my_inst_var = myvar
  end
  
  def self.class_method
  end

  def inst_method
  end
end

module TestModule
  def mytest
  end

  def self.mytest2
  end
end

class TestObjectDescribe < Test::Unit::TestCase

  def test_module_output

  result = ObjectDescribe.output(TestModule)

  check = <<eos
TestModule
==========
--Instance Methods
\tmytest
--Singleton Methods
\tmytest2
eos

    assert_equal(result,check)
  end

  def test_class_output
    result = ObjectDescribe.output TestClass
    check = <<eos
TestClass
=========
--Class Variables
\t@@my_class_var
--Instance Methods
\tmy_inst_var
\tmy_inst_var=
\tinst_method
--Class Methods
\tclass_method
eos

    assert_equal(result, check)
  end

  def test_instance_output
    result = ObjectDescribe.output(TestClass.new "Hello")
    check = <<eos
TestClass Instance
==================
--Instance Variables
\t@my_inst_var
--Instance Methods
\tmy_inst_var
\tmy_inst_var=
\tinst_method
eos

    assert_equal(result, check)
  end

  def test_object_instance_super_output
    result = ObjectDescribe.output(Object, {:instance_supers => true})
    check = <<eos
Object
======
--Instance Methods
\tpretty_print
\tpretty_print_cycle
\tpretty_print_instance_variables
\tpretty_print_inspect
\tnil?
\t===
\t=~
\t!~
\teql?
\thash
\t<=>
\tclass
\tsingleton_class
\tclone
\tdup
\tinitialize_dup
\tinitialize_clone
\ttaint
\ttainted?
\tuntaint
\tuntrust
\tuntrusted?
\ttrust
\tfreeze
\tfrozen?
\tto_s
\tinspect
\tmethods
\tsingleton_methods
\tprotected_methods
\tprivate_methods
\tpublic_methods
\tinstance_variables
\tinstance_variable_get
\tinstance_variable_set
\tinstance_variable_defined?
\tinstance_of?
\tkind_of?
\tis_a?
\ttap
\tsend
\tpublic_send
\trespond_to?
\trespond_to_missing?
\textend
\tdisplay
\tmethod
\tpublic_method
\tdefine_singleton_method
\tobject_id
\tto_enum
\tenum_for
\tpretty_inspect
\t==
\tequal?
\t!
\t!=
\tinstance_eval
\tinstance_exec
\t__send__
\t__id__
eos

    assert_equal(result, check)
  end
end

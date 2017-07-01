test =[]

test << {:id => "dfaksjkaaaakdjfak", :connection => "test"}
test << {:id => "dfakjadsmfkancckdn", :connection => "test2"}

id = "test"
test.each_with_index do |count, index|
	test.delete_at(index) if id === count[:connection]
end
p test.size

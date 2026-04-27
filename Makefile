LEX    = flex
CC     = gcc
CFLAGS = -w

BIN = bin
GEN = build

TARGETS = lab1 lab2 lab3 lab4 lab5 q1 q2 q3c q3cpp q3java

.PHONY: all test clean $(TARGETS) $(addprefix test_,$(TARGETS)) $(addprefix clean_,$(TARGETS))

all:  $(TARGETS)
test: $(addprefix test_,$(TARGETS))
clean: $(addprefix clean_,$(TARGETS))
	rm -rf $(BIN) $(GEN)

$(BIN) $(GEN):
	mkdir -p $@

define BUILD
$1: $2 | $(BIN) $(GEN)
	$(LEX) -o $(GEN)/$1.c $2
	$(CC) $(CFLAGS) -o $(BIN)/$1 $(GEN)/$1.c
endef

$(eval $(call BUILD,lab1,lab1.l))
$(eval $(call BUILD,lab2,lab2.l))
$(eval $(call BUILD,lab3,lab3.l))
$(eval $(call BUILD,lab4,lab4.l))
$(eval $(call BUILD,lab5,lab5.l))
$(eval $(call BUILD,q1,assignment_q1.l))
$(eval $(call BUILD,q2,assignment_q2.l))
$(eval $(call BUILD,q3c,assignment_q3-c.l))
$(eval $(call BUILD,q3cpp,assignment_q3-cpp.l))
$(eval $(call BUILD,q3java,assignment_q3-java.l))

test_lab1: lab1;   @echo "=== lab1 ===" && $(BIN)/lab1 < lab1test.txt
test_lab2: lab2;   @echo "=== lab2 ===" && $(BIN)/lab2 < lab2test.txt
test_lab3: lab3;   @echo "=== lab3 ===" && $(BIN)/lab3 < lab3test.txt
test_lab4: lab4;   @echo "=== lab4 ===" && $(BIN)/lab4 < lab4test.txt
test_lab5: lab5;   @echo "=== lab5 ===" && $(BIN)/lab5 < lab5test.txt
test_q1:   q1;    @echo "=== q1   ===" && $(BIN)/q1   < test_q1.txt
test_q2:   q2;    @echo "=== q2   ===" && $(BIN)/q2   < test_q2.txt
test_q3cpp:  q3cpp;  @echo "=== q3cpp  ===" && $(BIN)/q3cpp  < test_q3cpp.cpp
test_q3java: q3java; @echo "=== q3java ===" && $(BIN)/q3java < test_q3java.java
test_q3c: q3c
	@echo "=== q3c ==="
	$(LEX) -o $(GEN)/lex.yy.c assignment_q3-c.l
	$(BIN)/q3c < $(GEN)/lex.yy.c

$(addprefix clean_,$(TARGETS)):
	rm -f $(BIN)/$(subst clean_,,$@) $(GEN)/$(subst clean_,,$@).c

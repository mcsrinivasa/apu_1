# Makefile to compile and run APU_1 project

CC = gcc
CFLAG = -Isrc/apu_1/include -wall

RM = rm -rf
CLEAR = clear

SRC = src/apu_1/main.c $(wildcard src/apu_1/lib/*.c)
TEST_SRC = $(wildcard test/*.c)

OBJS = $(pathsub %.c, build/dist/artifacts/%.o, $(SRCS))
TEST_OBJS = $(pathsub %.c, build/test/artifacts/%o, $(TEST_SRC))

EXEC = build/dist/bin/apu1
TEST_EXEC = build/test/bin/apu1_test

all: $(EXEC) $(TEST_EXEC)

$(EXEC): $(OBJS)
	@mkdir -p $(dir $@)
	$(CC) $(OBJS) -o $(EXEC)

$(TEST_EXEC): $(TEST_OBJS) $(OBJS)
	@mkdir -p $(dir $@)
	$(CC) $(TEST_OBJS) $(OBJS) -o $(TEST_EXEC)

$(OBJS): $(SRC)
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c $< -o $@

$(TEST_OBJS): $(TEST_SRC)
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	$(RM) build

.PHONY: apu_1 clean

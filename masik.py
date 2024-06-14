from unicorn import *
from unicorn.x86_const import *
from getmc import asm_to_main_machine_code

data, main_addr = asm_to_main_machine_code('fakt.out')
instructions = list(map(lambda x: x[1], data))
ass_instructions : list = list(map(lambda x: x[2], data))
X86_CODE32 = []
for x in instructions:
    X86_CODE32.extend(x)

X86_CODE32 = bytes(X86_CODE32)
# ADDRESS = data[0][0]
ADDRESS = 0x1000000
try:
    # Initialize emulator in X86-32bit mode
    mu = Uc(UC_ARCH_X86, UC_MODE_64)
    print('debug')
    # map 2MB memory for this emulation
    mu.mem_map(ADDRESS, 30 * 1024 * 1024)
    print('xd')
    # write machine code to be emulated to memory
    mu.mem_write(ADDRESS, X86_CODE32)
    print('itt')
    # mu.reg_write(UC_X86_REG_ESP, ADDRESS + 0x200000)
    # len(X86_CODE32)
    mu.reg_write(UC_X86_REG_RIP, main_addr)
    print('ott')
    mu.emu_start(main_addr, 10)
    print('amott')

    r_ax = mu.reg_read(UC_X86_REG_EAX)
    r_bx = mu.reg_read(UC_X86_REG_EBX)
    i = mu.mem_read(mu.reg_read(UC_X86_REG_RBP)-2, 2)
    print(r_ax, r_bx, i)
except UcError as e:
    print("ERROR: %s" % e)
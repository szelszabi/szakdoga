from unicorn import *
from unicorn.x86_const import *
from getmc import asm_to_main_machine_code
import capstone

def my_hook_code(uc, address, size, user_data):
    md = capstone.Cs(capstone.CS_ARCH_X86, capstone.CS_MODE_64)
    inst_bytes = uc.mem_read(address,size)
    for i in md.disasm(inst_bytes, address):
        print("0x%x:\t%s\t%s" % (i.address, i.mnemonic, i.op_str))


data, main_addr = asm_to_main_machine_code('fakt.out')

# X86_CODE32 = b"\x66\xbb\x01\x00\x66\xb8\x01\x00\xeb\x08\x66\xf7\xe3\x66\x99\x66\xff\xc3\x66\x83\xfb\x05\x7e\xf2\x66\x89\xc1"
X86_CODE32 = bytes(data)
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
    mu.reg_write(UC_X86_REG_RSP, ADDRESS + 0x200000)

    mu.hook_add(UC_HOOK_CODE, my_hook_code)
    # len(X86_CODE32)
    print('ott')
    mu.emu_start(ADDRESS + main_addr, ADDRESS + len(X86_CODE32))
    print('amott')

    r_ax = mu.reg_read(UC_X86_REG_EAX)
    r_bx = mu.reg_read(UC_X86_REG_EBX)
    print(r_ax, r_bx)
except UcError as e:
    print("ERROR: %s" % e)
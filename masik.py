from unicorn import *
from unicorn.x86_const import *
from getmc import asm_to_main_machine_code
import capstone
import capstone.x86_const as cx86
import json

inst_counter = {}
const_counter = 0
mem_write = 0
mem_read = 0

def hook_mem_write(uc, access, address, size, value, user_data):
    global mem_write
    mem_write += 1

def hook_mem_read(uc, access, address, size, value, user_data):
    global mem_read
    mem_read += 1

def hook_code(uc, address, size, user_data):
    global const_counter
    md = capstone.Cs(capstone.CS_ARCH_X86, capstone.CS_MODE_64)
    md.detail = True
    inst_bytes = uc.mem_read(address,size)
    for i in md.disasm(inst_bytes, address):

        for operand in i.operands:
            if operand.type == cx86.X86_OP_IMM:
                print("\t\tIMM = 0x%x" %(operand.value.imm))
            if operand.type == cx86.X86_OP_MEM:
                print("\t\ttype: MEM")
                if operand.value.mem.base != 0:
                    print("\t\t\tmem.base: REG = %s" \
                        %(i.reg_name(operand.value.mem.base)))
                if operand.value.mem.index != 0:
                    print("\t\t\tmem.index: REG = %s" \
                        %(i.reg_name(operand.value.mem.index)))
                if operand.value.mem.disp != 0: # offset
                    print("\t\t\tmem.disp: 0x%x" \
                        %(operand.value.mem.disp))
                if operand.value.mem.scale != 0:
                    print(f"\t\t\tscale factor: {operand.value.mem.scale}")
                
            if operand.type == cx86.X86_OP_REG:
                print("\t\t.type: REG = %s" %(i.reg_name(operand.value.reg)))

        for operand in i.op_str.split(','):
            if "0x" in operand:
                const_counter += 1

        key = f"{hex(i.address)}    {i.mnemonic}"
        if  key not in list(inst_counter.keys()):
            inst_counter[key] = 1
        else:
            inst_counter[key] += 1
        #TODO függvények használatánál ez nem lesz hasznos
        if i.mnemonic == "ret":
            mu.emu_stop()
        print("0x%x:\t%s\t%s" % (i.address, i.mnemonic, i.op_str))


data, main_addr = asm_to_main_machine_code('a.out')

# X86_CODE32 = b"\x66\xbb\x01\x00\x66\xb8\x01\x00\xeb\x08\x66\xf7\xe3\x66\x99\x66\xff\xc3\x66\x83\xfb\x05\x7e\xf2\x66\x89\xc1"
X86_CODE32 = bytes(data)
ADDRESS = 0x0

mu = Uc(UC_ARCH_X86, UC_MODE_64)
try:
    mu.mem_map(ADDRESS, 30 * 1024 * 1024)
    mu.mem_write(ADDRESS, X86_CODE32)

    mu.reg_write(UC_X86_REG_RSP, ADDRESS + 0x200000)

    mu.hook_add(UC_HOOK_CODE, hook_code)
    mu.hook_add(UC_HOOK_MEM_WRITE, hook_mem_write)
    mu.hook_add(UC_HOOK_MEM_READ, hook_mem_read)

    mu.emu_start(ADDRESS + main_addr, ADDRESS + len(X86_CODE32))

    r_ax = mu.reg_read(UC_X86_REG_EAX)
    r_bx = mu.reg_read(UC_X86_REG_EBX)
    print(f"AX: {r_ax} BX: {r_bx}")
except UcError as e:
    print("ERROR: %s" % e)
    print(mu.reg_read(UC_X86_REG_RIP))

print(json.dumps(inst_counter,sort_keys=True, indent=4))
print(f"Konstansok száma: {const_counter}")
print(f"Memóriahozzáférések száma: {mem_write + mem_read}")

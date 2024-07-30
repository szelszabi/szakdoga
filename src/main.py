from unicorn import *
from unicorn.x86_const import *
from getmc import asm_to_main_machine_code
import capstone
import capstone.x86_const as cx86
import json
import jsbeautifier as jb


mem_addr_types_counter = {
    "O": 0,
    "B": 0,
    "BI": 0,
    "BO": 0,
    "BIO": 0,
    "BIS": 0,
    "ISO": 0,
    "BISO": 0
}
addr_counter = {}
instr_counter = {}
const_counter = 0
mem_write_counter = 0
mem_read_counter = 0

def hook_code(uc, address, size, user_data):
    global const_counter, mem_write_counter, mem_read_counter, mem_addr_types_counter
    md = capstone.Cs(capstone.CS_ARCH_X86, capstone.CS_MODE_64)
    md.detail = True
    inst_bytes = uc.mem_read(address,size)
    for i in md.disasm(inst_bytes, address):

        for op in i.operands:
            if op.type == cx86.X86_OP_IMM:
                #print("\t\tIMM = 0x%x" %(op.value.imm))
                const_counter += 1


            if op.type == cx86.X86_OP_MEM:
                # print("\t\ttype: MEM")
                (B, I, S, O) = (op.mem.base, op.mem.index, op.mem.scale, op.mem.disp)
                """ if op.mem.base != 0:
                    print("\t\t\tmem.base: REG = %s" \
                        %(i.reg_name(op.mem.base)))
                if op.mem.index != 0:
                    print("\t\t\tmem.index: REG = %s" \
                        %(i.reg_name(op.mem.index)))
                if op.mem.disp != 0: # offset
                    print("\t\t\tmem.disp: 0x%x" \
                        %(op.mem.disp))
                if op.mem.scale != 0:
                    print(f"\t\t\tscale factor: {op.mem.scale}") """
                
                if B == 0 and I == 0 and S == 1 and O != 0:
                    mem_addr_types_counter["O"] += 1
                elif B != 0 and I == 0 and S == 1 and O == 0:
                    mem_addr_types_counter["B"] += 1
                elif B != 0 and I != 0 and S == 1 and O == 0:
                    mem_addr_types_counter["BI"] += 1
                elif B != 0 and I == 0 and S == 1 and O != 0:
                    mem_addr_types_counter["BO"] += 1
                elif B != 0 and I != 0 and S == 1 and O != 0:
                    mem_addr_types_counter["BIO"] += 1
                elif B != 0 and I != 0 and S != 1 and O == 0:
                    mem_addr_types_counter["BIS"] += 1
                elif B == 0 and I != 0 and S != 1 and O != 0:
                    mem_addr_types_counter["ISO"] += 1
                elif B != 0 and I != 0 and S != 1 and O != 0:
                    mem_addr_types_counter["BISO"] += 1

                match(op.access):
                    case capstone.CS_AC_READ:
                        mem_read_counter += 1
                    case capstone.CS_AC_WRITE:
                        mem_write_counter += 1


            if op.type == cx86.X86_OP_REG:
                pass
                #print("\t\t.type: REG = %s" %(i.reg_name(op.value.reg)))

            
        
        addr_key = f"{hex(i.address)}"
        if  addr_key not in list(addr_counter.keys()):
            addr_counter[addr_key] = (i.mnemonic, 1)
        else:
            x = addr_counter[addr_key][1]
            addr_counter[addr_key] = (i.mnemonic, x+1)

        if i.mnemonic not in list(instr_counter.keys()):
            instr_counter[i.mnemonic] = 1
        else:
            instr_counter[i.mnemonic] += 1


        if i.mnemonic == "ret":
            top_of_stack = mu.mem_read(mu.reg_read(UC_X86_REG_RSP), 8)
            top_of_stack.reverse()
            if top_of_stack == b'STOPVEGE':
                mu.emu_stop()
        # print("0x%x:\t%s\t%s" % (i.address, i.mnemonic, i.op_str))


data, main_addr = asm_to_main_machine_code('a.oMs. Pac-Manut')

# X86_CODE32 = b"\x66\xbb\x01\x00\x66\xb8\x01\x00\xeb\x08\x66\xf7\xe3\x66\x99\x66\xff\xc3\x66\x83\xfb\x05\x7e\xf2\x66\x89\xc1"
INIT_CODE = b"\x48\xb8\x45\x47\x45\x56\x50\x4f\x54\x53\x50" # Pushes 'STOPVEGE' in binary to stack
X86_CODE32 = bytes(data)
ADDRESS = 0x0

mu = Uc(UC_ARCH_X86, UC_MODE_64)
try:
    mu.mem_map(ADDRESS, 30 * 1024 * 1024)

    mu.reg_write(UC_X86_REG_RSP, ADDRESS + 0x1000000)

    mu.mem_write(ADDRESS, INIT_CODE)
    mu.emu_start(ADDRESS, ADDRESS + len(INIT_CODE))

    mu.hook_add(UC_HOOK_CODE, hook_code)

    mu.mem_write(ADDRESS, X86_CODE32)
    mu.emu_start(ADDRESS + main_addr, ADDRESS + len(X86_CODE32))

    r_ax = mu.reg_read(UC_X86_REG_EAX)
    r_bx = mu.reg_read(UC_X86_REG_EBX)
except UcError as e:
    print("ERROR: %s" % e)
    print(mu.reg_read(UC_X86_REG_RIP))


options = jb.default_options()
options.keep_array_indentation = True
print("Hányszor ugrott egyes címekre:")
print(jb.beautify(json.dumps(addr_counter), options))

print("Memória címzések típusok száma:")
print(jb.beautify(json.dumps(mem_addr_types_counter), options))

print("Mnemonikok száma:")
print(jb.beautify(json.dumps(instr_counter), options))

print(f"Konstansok száma: {const_counter}")
print(f"Memóriahozzáférések száma: {mem_write_counter + mem_read_counter}")
print(f"Memória írás: {mem_write_counter}")
print(f"Memória olvas: {mem_read_counter}")

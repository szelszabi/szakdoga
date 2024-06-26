from unicorn import *
from unicorn.x86_const import *

# code to be emulated
X86_CODE32 = b"\xFF\xC1" # INC ecx; DEC edx f3 0f 1e fa
X86_CODE32 = b"\x66\xbb\x01\x00\x66\xb8\x01\x00\xeb\x08\x66\xf7\xe3\x66\x99\x66\xff\xc3\x66\x83\xfb\x05\x7e\xf2\x66\x89\xc1\xc3"
# memory address where emulation starts
ADDRESS = 0x1000000

print("Emulate i386 code")
try:
    # Initialize emulator in X86-32bit mode
    mu = Uc(UC_ARCH_X86, UC_MODE_32)

    # map 2MB memory for this emulation
    mu.mem_map(ADDRESS, 2 * 1024 * 1024)

    # write machine code to be emulated to memory
    mu.mem_write(ADDRESS, X86_CODE32)
    # initialize machine registers
    mu.reg_write(UC_X86_REG_ECX, 0x1234)
    mu.reg_write(UC_X86_REG_EDX, 0x7890)

    # emulate code in infinite time & unlimited instructions
    mu.emu_start(ADDRESS, ADDRESS + 4)

    # now print out some registers
    print("Emulation done. Below is the CPU context")

    r_ecx = mu.reg_read(UC_X86_REG_ECX)
    r_edx = mu.reg_read(UC_X86_REG_EDX)
    print(">>> ECX = 0x%x" %r_ecx)
    print(">>> EDX = 0x%x" %r_edx)

    # now print out some registers
    print("Emulation done. Below is the CPU context")

    r_ecx = mu.reg_read(UC_X86_REG_ECX)
    r_edx = mu.reg_read(UC_X86_REG_EDX)
    print(">>> ECX = 0x%x" %r_ecx)
    print(">>> EDX = 0x%x" %r_edx)

except UcError as e:
    print("ERROR: %s" % e)

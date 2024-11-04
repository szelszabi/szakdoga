import os


def fill(first, first_size, curr):
    return (curr-first + first_size) * [0]

def compile_code(fname):
    extension = fname[fname.rfind('.')+1:]
    output_fname = fname[0:fname.rfind('.')] + ("_C" if extension == "c" else "_ASM") + ".out"
    os.system(f"gcc asm_src/{fname} -o bin/{output_fname}")
    return output_fname


def asm_to_main_machine_code(fname: str) -> list[int]:
    result = []
    main_mem_address = 0
    is_next_main = False
    bin_fname = compile_code(fname)
    os.system(f"objdump -D -z -d -M intel --start-address=0x0 bin/{bin_fname} > dump_files/dumpi.tmp")
    try:
        file = open("dump_files/dumpi.tmp", "r")
    except IOError:
        print("Couldn't open file: dump_files/dumpi.tmp")
        raise IOError
    lines = file.readlines()
    file.close()

    after_dis = False
    last_line = ""

    for line in lines:
        machine_code = ''
        if line.count('\t') == 2:
            machine_code = line[line.find('\t'):line.rfind('\t')+1].strip()
        elif line.count('\t') == 1:
            machine_code = line[line.find('\t'):].strip()
        last_instr_len = 0
        
        if machine_code != '':
            if is_next_main:
                main_mem_address = len(result)
                is_next_main = False

            instr_code = []
            for byte in machine_code.split():
                instr_code.append(int(byte,16))
            result.extend(instr_code)

            if after_dis:
                last_addr = last_line.split(':')[0].strip()
                before_addr = int(last_addr,16) if last_addr != '' else 0
                after_addr = int(line.split(':')[0].strip(), 16)
                filler = fill(before_addr, last_instr_len, after_addr)
                result.extend(filler)
                after_dis = False
        
            last_line = line
            last_instr_len = len(instr_code)

        if "<main>" in line:
            is_next_main = True
        elif "Disassembly of section" in line:
            after_dis = True
        elif ".comment" in line or len(result) > 4198695:
            break

    for x in result:
        #print(hex(x), end=', ')
        pass
    return (result,main_mem_address)


if __name__ == '__main__':
    #print(bytes(fill(40,3,60)))
    asm_to_main_machine_code('a.out')
    pass
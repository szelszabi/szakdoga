import os


def fill(first, first_size, curr):
    # -1 nem biztos, hogy kell majd kiderül
    return (curr-(first + first_size)) * [0]

def asm_to_main_machine_code(fname: str) -> list[int]:
    result = []

    main_mem_address = 0
    is_next_main = False

    os.system(f"objdump -D -z -d -M intel ../bin/{fname} > ../dump_files/dumpi.tmp")
    try:
        file = open("../dump_files/dumpi.tmp", "r")
    except OSError:
        raise OSError
    lines = file.readlines()
    file.close()

    after_dis = False
    last_line = ""

    for line in lines:
        machine_code = line[line.find('\t'):line.rfind('\t')+1].strip()
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
        elif ".comment" in line:
            break

    # try:
    #     os.remove("dumpi.tmp")
    # finally:
    return (result,main_mem_address)
""" 
Futtatható állományt vár 
"""    

if __name__ == '__main__':
    #print(bytes(fill(40,3,60)))
    asm_to_main_machine_code('a.out')
    pass
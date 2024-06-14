import os


def asm_to_main_machine_code(fname: str) -> list[int]:
    os.system(f"objdump -D -z -d -M intel {fname} > dumpi.tmp")
    r = []
    f = open("dumpi.tmp", "r")
    lines = f.readlines()
    f.close()
    for line in lines:
        machine_code = line[line.find('\t'):line.rfind('\t')+1].strip()
            
        if machine_code != '':
            address = int(line[:line.find(":")].lstrip(),16) # Memory address

            instr_code = []
            for byte in machine_code.split():
                instr_code.append(int(byte,16))

            instruction = line[line.rfind('\t')+1:line.rfind('#')]
            r.append((address, instr_code, instruction))
    # try:
    #     os.remove("dumpi.tmp")
    # finally:
    return r
""" 
Futtatható állományt vár 
"""    

if __name__ == '__main__':
    r = asm_to_main_machine_code("fakt.out")
    [print(x) for x in r]

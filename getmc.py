import os


def asm_to_main_machine_code(fname: str) -> list[int]:
    os.system(f"objdump -D -z -d -M intel {fname} > dumpi.tmp")
    r = []
    main_mem_address = 0
    f = open("dumpi.tmp", "r")
    lines = f.readlines()
    is_next_main = False
    f.close()
    for line in lines:
        machine_code = line[line.find('\t'):line.rfind('\t')+1].strip()
        if machine_code != '':
            if is_next_main:
                main_mem_address = len(r)
                is_next_main = False
            instr_code = []
            for byte in machine_code.split():
                instr_code.append(int(byte,16))
            r.extend(instr_code)
        
        if line.find("<main>:") != -1:
            is_next_main = True
    # try:
    #     os.remove("dumpi.tmp")
    # finally:
    return (r,main_mem_address)
""" 
Futtatható állományt vár 
"""    

if __name__ == '__main__':
    r, mainadd = asm_to_main_machine_code("fakt.out")
    # [print(x) for x in r]
    print(hex(mainadd))

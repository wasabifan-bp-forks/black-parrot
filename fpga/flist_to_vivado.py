#!/usr/bin/python

from os.path import normpath
import sys
import os
import posixpath

def subst_var(string, varname, value):
    return string.replace("$" + varname, value)

def subst_vars(string, substitutions):
    for varname, value in substitutions.items():
        string = subst_var(string, varname, value)

    return string

INCDIR_PREFIX = "+incdir+"

def load_flist(file_path, variable_substitutions):
    """
    Returns a tuple (path, is_include).
    """

    with open(file_path) as flist_file:
        lines = map(str.strip, flist_file.readlines())

    result = []
    for line in lines:
        if line.startswith("#") or len(line) == 0:
            continue

        if line.startswith(INCDIR_PREFIX):
            dir_line = line[len(INCDIR_PREFIX):]
            result.append((subst_vars(dir_line, variable_substitutions), True))
        else:
            result.append((subst_vars(line, variable_substitutions), False))

    return result

if __name__ == "__main__":
    _, flist_file, repo_root_dir = sys.argv

    variable_substitutions = {
        "BP_TOP_DIR": "bp_top",
        "BP_COMMON_DIR": "bp_common",
        "BP_BE_DIR": "bp_be",
        "BP_FE_DIR": "bp_fe",
        "BP_ME_DIR": "bp_me",
        "BASEJUMP_STL_DIR": "external/basejump_stl",
        "HARDFLOAT_DIR": "external/HardFloat",
    }

    file_specs = load_flist(flist_file, variable_substitutions)

    all_non_include_files = set(( posixpath.normpath(path) for path, is_include in file_specs if not is_include ))

    expanded_files = []
    for spec in file_specs:
        path, is_include = spec
        if not is_include:
            normed_path = posixpath.normpath(path)
            expanded_files.append((normed_path, False))
            continue

        abs_path = os.path.join(repo_root_dir, path)
        dir_files = os.listdir(abs_path)
        dir_files_abs = map(lambda name: posixpath.normpath(posixpath.join(path, name)), dir_files)

        def _is_valid(path):
            is_file = os.path.isfile(os.path.join(repo_root_dir, path))
            appropriate_extension = os.path.splitext(path)[1] in (".v", ".vh", ".sv", ".svh", ".vi")
            explicitly_added_later = path in all_non_include_files

            return is_file and appropriate_extension and not explicitly_added_later

        dir_files_abs_valid = list(filter(_is_valid, dir_files_abs))
        dir_file_specs = list(zip(dir_files_abs_valid, [True] * len(dir_files_abs_valid)))
        expanded_files.extend(dir_file_specs)

    fileset_entries = []
    props_entries = []

    for file_path, is_include in expanded_files:
        fileset_entry_template = "[file normalize \"${{origin_dir}}/../../{}\"] \\"
        fileset_entries.append(fileset_entry_template.format(file_path))

        file_type = "Verilog Header" if is_include else "SystemVerilog"

        props_entry = """
set file "${{origin_dir}}/../../{}"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "{}" -objects $file_obj
        """.strip().format(file_path, file_type)

        props_entries.append(props_entry)

    with open("fileset.txt", "w") as f:
        f.write("\n".join(fileset_entries))

    with open("props.txt", "w") as f:
        f.write("\n\n".join(props_entries))

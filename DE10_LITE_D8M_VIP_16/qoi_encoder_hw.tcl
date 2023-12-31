# TCL File Generated by Component Editor 18.1
# Tue Jun 13 14:30:49 BST 2023
# DO NOT MODIFY


# 
# qoi_encoder "qoi_encoder" v1.0
# Harry Griffiths 2023.06.13.14:30:49
# Quite Okay Image Encoder
# 

# 
# request TCL package from ACDS 16.1
# 
package require -exact qsys 16.1


# 
# module qoi_encoder
# 
set_module_property DESCRIPTION "Quite Okay Image Encoder"
set_module_property NAME qoi_encoder
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property AUTHOR "Harry Griffiths"
set_module_property DISPLAY_NAME qoi_encoder
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL qoi_encoder
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property QUARTUS_SYNTH ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file qoi_encoder.sv SYSTEM_VERILOG PATH qoi_encoder.sv TOP_LEVEL_FILE


# 
# parameters
# 
add_parameter IMAGE_W STD_LOGIC_VECTOR 640
set_parameter_property IMAGE_W DEFAULT_VALUE 640
set_parameter_property IMAGE_W DISPLAY_NAME IMAGE_W
set_parameter_property IMAGE_W WIDTH 13
set_parameter_property IMAGE_W TYPE STD_LOGIC_VECTOR
set_parameter_property IMAGE_W UNITS None
set_parameter_property IMAGE_W ALLOWED_RANGES 0:8191
set_parameter_property IMAGE_W HDL_PARAMETER true
add_parameter IMAGE_H STD_LOGIC_VECTOR 480
set_parameter_property IMAGE_H DEFAULT_VALUE 480
set_parameter_property IMAGE_H DISPLAY_NAME IMAGE_H
set_parameter_property IMAGE_H WIDTH 13
set_parameter_property IMAGE_H TYPE STD_LOGIC_VECTOR
set_parameter_property IMAGE_H UNITS None
set_parameter_property IMAGE_H ALLOWED_RANGES 0:8191
set_parameter_property IMAGE_H HDL_PARAMETER true
add_parameter MESSAGE_BUF_MAX INTEGER 256
set_parameter_property MESSAGE_BUF_MAX DEFAULT_VALUE 256
set_parameter_property MESSAGE_BUF_MAX DISPLAY_NAME MESSAGE_BUF_MAX
set_parameter_property MESSAGE_BUF_MAX TYPE INTEGER
set_parameter_property MESSAGE_BUF_MAX UNITS None
set_parameter_property MESSAGE_BUF_MAX ALLOWED_RANGES -2147483648:2147483647
set_parameter_property MESSAGE_BUF_MAX HDL_PARAMETER true
add_parameter MSG_INTERVAL INTEGER 6
set_parameter_property MSG_INTERVAL DEFAULT_VALUE 6
set_parameter_property MSG_INTERVAL DISPLAY_NAME MSG_INTERVAL
set_parameter_property MSG_INTERVAL TYPE INTEGER
set_parameter_property MSG_INTERVAL UNITS None
set_parameter_property MSG_INTERVAL ALLOWED_RANGES -2147483648:2147483647
set_parameter_property MSG_INTERVAL HDL_PARAMETER true
add_parameter BB_COL_DEFAULT STD_LOGIC_VECTOR 65280
set_parameter_property BB_COL_DEFAULT DEFAULT_VALUE 65280
set_parameter_property BB_COL_DEFAULT DISPLAY_NAME BB_COL_DEFAULT
set_parameter_property BB_COL_DEFAULT WIDTH 26
set_parameter_property BB_COL_DEFAULT TYPE STD_LOGIC_VECTOR
set_parameter_property BB_COL_DEFAULT UNITS None
set_parameter_property BB_COL_DEFAULT ALLOWED_RANGES 0:67108863
set_parameter_property BB_COL_DEFAULT HDL_PARAMETER true


# 
# display items
# 


# 
# connection point clk
# 
add_interface clk clock end
set_interface_property clk clockRate 0
set_interface_property clk ENABLED true
set_interface_property clk EXPORT_OF ""
set_interface_property clk PORT_NAME_MAP ""
set_interface_property clk CMSIS_SVD_VARIABLES ""
set_interface_property clk SVD_ADDRESS_GROUP ""

add_interface_port clk clk clk Input 1


# 
# connection point reset
# 
add_interface reset reset end
set_interface_property reset associatedClock clk
set_interface_property reset synchronousEdges DEASSERT
set_interface_property reset ENABLED true
set_interface_property reset EXPORT_OF ""
set_interface_property reset PORT_NAME_MAP ""
set_interface_property reset CMSIS_SVD_VARIABLES ""
set_interface_property reset SVD_ADDRESS_GROUP ""

add_interface_port reset reset_n reset_n Input 1


# 
# connection point avalon_streaming_sink
# 
add_interface avalon_streaming_sink avalon_streaming end
set_interface_property avalon_streaming_sink associatedClock clk
set_interface_property avalon_streaming_sink associatedReset reset
set_interface_property avalon_streaming_sink dataBitsPerSymbol 8
set_interface_property avalon_streaming_sink errorDescriptor ""
set_interface_property avalon_streaming_sink firstSymbolInHighOrderBits true
set_interface_property avalon_streaming_sink maxChannel 0
set_interface_property avalon_streaming_sink readyLatency 0
set_interface_property avalon_streaming_sink ENABLED true
set_interface_property avalon_streaming_sink EXPORT_OF ""
set_interface_property avalon_streaming_sink PORT_NAME_MAP ""
set_interface_property avalon_streaming_sink CMSIS_SVD_VARIABLES ""
set_interface_property avalon_streaming_sink SVD_ADDRESS_GROUP ""

add_interface_port avalon_streaming_sink sink_data data Input 24
add_interface_port avalon_streaming_sink sink_valid valid Input 1
add_interface_port avalon_streaming_sink sink_ready ready Output 1
add_interface_port avalon_streaming_sink sink_sop startofpacket Input 1
add_interface_port avalon_streaming_sink sink_eop endofpacket Input 1


# 
# connection point avalon_streaming_source
# 
add_interface avalon_streaming_source avalon_streaming start
set_interface_property avalon_streaming_source associatedClock clk
set_interface_property avalon_streaming_source associatedReset reset
set_interface_property avalon_streaming_source dataBitsPerSymbol 8
set_interface_property avalon_streaming_source errorDescriptor ""
set_interface_property avalon_streaming_source firstSymbolInHighOrderBits true
set_interface_property avalon_streaming_source maxChannel 0
set_interface_property avalon_streaming_source readyLatency 0
set_interface_property avalon_streaming_source ENABLED true
set_interface_property avalon_streaming_source EXPORT_OF ""
set_interface_property avalon_streaming_source PORT_NAME_MAP ""
set_interface_property avalon_streaming_source CMSIS_SVD_VARIABLES ""
set_interface_property avalon_streaming_source SVD_ADDRESS_GROUP ""

add_interface_port avalon_streaming_source source_data data Output 48
add_interface_port avalon_streaming_source source_valid valid Output 1
add_interface_port avalon_streaming_source source_ready ready Input 1
add_interface_port avalon_streaming_source source_eop endofpacket Output 1
add_interface_port avalon_streaming_source source_sop startofpacket Output 1


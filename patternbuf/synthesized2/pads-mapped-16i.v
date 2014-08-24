
module patternbuffer ( buf_fieldp, buf_fieldwp, field_write_en, field_out, 
        field_in );
  input [7:0] buf_fieldp;
  input [7:0] buf_fieldwp;
  output [7:0] field_out;
  input [7:0] field_in;
  input field_write_en;


endmodule


module digital ( clk, reset, inputs, imem_write_adr, imem_write, imem_in, 
        outputs, \acc_out[7] , \acc_out[6] , \acc_out[5] , \acc_out[4]_BAR , 
        \acc_out[3] , \acc_out[2] , \acc_out[1]_BAR , \acc_out[0]_BAR  );
  input [7:0] inputs;
  input [9:0] imem_write_adr;
  input [39:0] imem_in;
  output [7:0] outputs;
  input clk, reset, imem_write;
  output \acc_out[7] , \acc_out[6] , \acc_out[5] , \acc_out[4]_BAR ,
         \acc_out[3] , \acc_out[2] , \acc_out[1]_BAR , \acc_out[0]_BAR ;
  wire   n1569, n1570, n1571, n1572, field_write_en, \iBuffer/n64 ,
         \iBuffer/n63 , \iBuffer/n40 , \iBuffer/n39 , \iBuffer/n38 ,
         \iBuffer/n37 , \iBuffer/n36 , \iBuffer/n35 , \iBuffer/n34 ,
         \iBuffer/n33 , \iBuffer/n32 , \iBuffer/n31 , \iBuffer/n30 ,
         \iBuffer/n29 , \iBuffer/n28 , \iBuffer/n27 , \iBuffer/n26 ,
         \iBuffer/n25 , \iBuffer/n24 , \iBuffer/n23 , \iBuffer/n22 ,
         \iBuffer/n21 , \iBuffer/n20 , \iBuffer/n19 , \iBuffer/n18 ,
         \iBuffer/n17 , \iBuffer/n16 , \iBuffer/n15 , \iBuffer/n14 ,
         \iBuffer/n13 , \iBuffer/n12 , \iBuffer/n11 , \iBuffer/n10 ,
         \iBuffer/n9 , \iBuffer/n8 , \iBuffer/n7 , \iBuffer/n6 , \iBuffer/n5 ,
         \iBuffer/n4 , \iBuffer/n3 , \iBuffer/n2 , \iBuffer/n1 , \iBuffer/N50 ,
         \iBuffer/N49 , \iBuffer/N48 , \iBuffer/N47 , \iBuffer/N46 ,
         \iBuffer/N45 , \iBuffer/N44 , \iBuffer/N43 , \iBuffer/N42 ,
         \iBuffer/N41 , \iBuffer/N40 , \iBuffer/N39 , \iBuffer/N38 ,
         \iBuffer/N37 , \iBuffer/N36 , \iBuffer/N35 , \iBuffer/N34 ,
         \iBuffer/N33 , \iBuffer/N32 , \iBuffer/N31 ,
         \iBuffer/i_buffer[0][19] , \iBuffer/i_buffer[0][18] ,
         \iBuffer/i_buffer[0][17] , \iBuffer/i_buffer[0][16] ,
         \iBuffer/i_buffer[0][15] , \iBuffer/i_buffer[0][14] ,
         \iBuffer/i_buffer[0][13] , \iBuffer/i_buffer[0][12] ,
         \iBuffer/i_buffer[0][11] , \iBuffer/i_buffer[0][10] ,
         \iBuffer/i_buffer[0][9] , \iBuffer/i_buffer[0][8] ,
         \iBuffer/i_buffer[0][7] , \iBuffer/i_buffer[0][6] ,
         \iBuffer/i_buffer[0][5] , \iBuffer/i_buffer[0][4] ,
         \iBuffer/i_buffer[0][3] , \iBuffer/i_buffer[0][2] ,
         \iBuffer/i_buffer[0][1] , \iBuffer/i_buffer[0][0] ,
         \iBuffer/i_buffer[1][19] , \iBuffer/i_buffer[1][18] ,
         \iBuffer/i_buffer[1][17] , \iBuffer/i_buffer[1][16] ,
         \iBuffer/i_buffer[1][15] , \iBuffer/i_buffer[1][14] ,
         \iBuffer/i_buffer[1][13] , \iBuffer/i_buffer[1][12] ,
         \iBuffer/i_buffer[1][11] , \iBuffer/i_buffer[1][10] ,
         \iBuffer/i_buffer[1][9] , \iBuffer/i_buffer[1][8] ,
         \iBuffer/i_buffer[1][7] , \iBuffer/i_buffer[1][6] ,
         \iBuffer/i_buffer[1][5] , \iBuffer/i_buffer[1][4] ,
         \iBuffer/i_buffer[1][3] , \iBuffer/i_buffer[1][2] ,
         \iBuffer/i_buffer[1][1] , \iBuffer/i_buffer[1][0] ,
         \iBuffer/jump_bubble[0] , \iBuffer/jump_bubble[1] , \thePAT/n810 ,
         \thePAT/n809 , \thePAT/n808 , \thePAT/n807 , \thePAT/n806 ,
         \thePAT/n805 , \thePAT/n804 , \thePAT/n803 , \thePAT/n802 ,
         \thePAT/n801 , \thePAT/n800 , \thePAT/n799 , \thePAT/n798 ,
         \thePAT/n797 , \thePAT/n796 , \thePAT/n795 , \thePAT/n794 ,
         \thePAT/n793 , \thePAT/n792 , \thePAT/n791 , \thePAT/n790 ,
         \thePAT/n789 , \thePAT/n788 , \thePAT/n787 , \thePAT/n786 ,
         \thePAT/n785 , \thePAT/n784 , \thePAT/n783 , \thePAT/n782 ,
         \thePAT/n781 , \thePAT/n780 , \thePAT/n779 , \thePAT/n778 ,
         \thePAT/n777 , \thePAT/n776 , \thePAT/n775 , \thePAT/n774 ,
         \thePAT/n773 , \thePAT/n772 , \thePAT/n771 , \thePAT/n770 ,
         \thePAT/n769 , \thePAT/n768 , \thePAT/n767 , \thePAT/n766 ,
         \thePAT/n765 , \thePAT/n764 , \thePAT/n763 , \thePAT/n762 ,
         \thePAT/n761 , \thePAT/n760 , \thePAT/n759 , \thePAT/n758 ,
         \thePAT/n757 , \thePAT/n756 , \thePAT/n755 , \thePAT/n754 ,
         \thePAT/n753 , \thePAT/n752 , \thePAT/n751 , \thePAT/n750 ,
         \thePAT/n749 , \thePAT/n748 , \thePAT/n747 , \thePAT/n746 ,
         \thePAT/n745 , \thePAT/n744 , \thePAT/n743 , \thePAT/n742 ,
         \thePAT/n741 , \thePAT/n740 , \thePAT/n739 , \thePAT/n738 ,
         \thePAT/n737 , \thePAT/n736 , \thePAT/n735 , \thePAT/n734 ,
         \thePAT/n733 , \thePAT/n732 , \thePAT/n731 , \thePAT/n730 ,
         \thePAT/n729 , \thePAT/n728 , \thePAT/n727 , \thePAT/n726 ,
         \thePAT/n725 , \thePAT/n724 , \thePAT/n723 , \thePAT/n722 ,
         \thePAT/n721 , \thePAT/n720 , \thePAT/n719 , \thePAT/n718 ,
         \thePAT/n717 , \thePAT/n716 , \thePAT/n715 , \thePAT/n714 ,
         \thePAT/n713 , \thePAT/n712 , \thePAT/n711 , \thePAT/n710 ,
         \thePAT/n709 , \thePAT/n708 , \thePAT/n707 , \thePAT/n706 ,
         \thePAT/n705 , \thePAT/n704 , \thePAT/n703 , \thePAT/n702 ,
         \thePAT/n701 , \thePAT/n700 , \thePAT/n699 , \thePAT/n698 ,
         \thePAT/n697 , \thePAT/n696 , \thePAT/n695 , \thePAT/n694 ,
         \thePAT/n693 , \thePAT/n692 , \thePAT/n691 , \thePAT/n690 ,
         \thePAT/n689 , \thePAT/n688 , \thePAT/n687 , \thePAT/n686 ,
         \thePAT/n685 , \thePAT/n684 , \thePAT/n683 , \thePAT/n682 ,
         \thePAT/n681 , \thePAT/n680 , \thePAT/n679 , \thePAT/n678 ,
         \thePAT/n677 , \thePAT/n676 , \thePAT/n675 , \thePAT/n674 ,
         \thePAT/n673 , \thePAT/n672 , \thePAT/n671 , \thePAT/n670 ,
         \thePAT/n669 , \thePAT/n668 , \thePAT/n667 , \thePAT/n666 ,
         \thePAT/n665 , \thePAT/n664 , \thePAT/n663 , \thePAT/n662 ,
         \thePAT/n661 , \thePAT/n660 , \thePAT/n659 , \thePAT/n658 ,
         \thePAT/n657 , \thePAT/n656 , \thePAT/n655 , \thePAT/n654 ,
         \thePAT/n653 , \thePAT/n652 , \thePAT/n651 , \thePAT/n650 ,
         \thePAT/n649 , \thePAT/n648 , \thePAT/n647 , \thePAT/n646 ,
         \thePAT/n645 , \thePAT/n644 , \thePAT/n643 , \thePAT/n642 ,
         \thePAT/n641 , \thePAT/n640 , \thePAT/n639 , \thePAT/n638 ,
         \thePAT/n637 , \thePAT/n636 , \thePAT/n80 , \thePAT/n79 ,
         \thePAT/n78 , \thePAT/n77 , \thePAT/n76 , \thePAT/n75 , \thePAT/n74 ,
         \thePAT/n73 , \thePAT/n70 , \thePAT/n68 , \thePAT/n64 , \thePAT/n57 ,
         \thePAT/n46 , \thePAT/n35 , \thePAT/n29 , \thePAT/n28 , \thePAT/n27 ,
         \thePAT/n26 , \thePAT/n25 , \thePAT/n17 , \thePAT/n16 , \thePAT/n15 ,
         \thePAT/n14 , \thePAT/n13 , \thePAT/n12 , \thePAT/n11 , \thePAT/n10 ,
         \thePAT/n9 , \thePAT/n8 , \thePAT/n7 , \thePAT/n6 ,
         \thePAT/thePC/pc[9] , \thePAT/thePC/pc[8] , \thePAT/thePC/pc[7] ,
         \thePAT/thePC/pc[6] , \thePAT/thePC/pc[5] , \thePAT/thePC/pc[4] ,
         \thePAT/thePC/pc[3] , \thePAT/thePC/pc[2] , \thePAT/thePC/pc[1] ,
         \thePAT/thePC/pc[0] , \thePAT/thePC/pcInc[8] ,
         \thePAT/thePC/pcInc[7] , \thePAT/thePC/pcInc[6] ,
         \thePAT/thePC/pcInc[5] , \thePAT/thePC/pcInc[4] ,
         \thePAT/thePC/pcInc[3] , \thePAT/thePC/pcInc[2] ,
         \thePAT/thePC/pcInc[1] , \thePAT/thePC/pcAdd[8] ,
         \thePAT/thePC/pcAdd[4] , \thePAT/thePC/pcAdd[3] ,
         \thePAT/thePC/pcAdd[2] , \thePAT/thePC/N3 , \thePAT/thePC/N4 ,
         \thePAT/thePC/N5 , \thePAT/thePC/N6 , \thePAT/thePC/N7 ,
         \thePAT/thePC/N8 , \thePAT/thePC/N9 , \thePAT/thePC/N21 ,
         \thePAT/thePC/N22 , \thePAT/thePC/N23 , \thePAT/dmem/dmem[0][7] ,
         \thePAT/dmem/dmem[0][6] , \thePAT/dmem/dmem[0][5] ,
         \thePAT/dmem/dmem[0][4] , \thePAT/dmem/dmem[0][3] ,
         \thePAT/dmem/dmem[0][2] , \thePAT/dmem/dmem[0][1] ,
         \thePAT/dmem/dmem[0][0] , \thePAT/dmem/dmem[1][7] ,
         \thePAT/dmem/dmem[1][6] , \thePAT/dmem/dmem[1][5] ,
         \thePAT/dmem/dmem[1][4] , \thePAT/dmem/dmem[1][3] ,
         \thePAT/dmem/dmem[1][2] , \thePAT/dmem/dmem[1][1] ,
         \thePAT/dmem/dmem[1][0] , \thePAT/dmem/dmem[2][7] ,
         \thePAT/dmem/dmem[2][6] , \thePAT/dmem/dmem[2][5] ,
         \thePAT/dmem/dmem[2][4] , \thePAT/dmem/dmem[2][3] ,
         \thePAT/dmem/dmem[2][2] , \thePAT/dmem/dmem[2][1] ,
         \thePAT/dmem/dmem[2][0] , \thePAT/dmem/dmem[3][7] ,
         \thePAT/dmem/dmem[3][6] , \thePAT/dmem/dmem[3][5] ,
         \thePAT/dmem/dmem[3][4] , \thePAT/dmem/dmem[3][3] ,
         \thePAT/dmem/dmem[3][2] , \thePAT/dmem/dmem[3][1] ,
         \thePAT/dmem/dmem[3][0] , \thePAT/dmem/dmem[4][7] ,
         \thePAT/dmem/dmem[4][6] , \thePAT/dmem/dmem[4][5] ,
         \thePAT/dmem/dmem[4][4] , \thePAT/dmem/dmem[4][3] ,
         \thePAT/dmem/dmem[4][2] , \thePAT/dmem/dmem[4][1] ,
         \thePAT/dmem/dmem[4][0] , \thePAT/dmem/dmem[5][7] ,
         \thePAT/dmem/dmem[5][6] , \thePAT/dmem/dmem[5][5] ,
         \thePAT/dmem/dmem[5][4] , \thePAT/dmem/dmem[5][3] ,
         \thePAT/dmem/dmem[5][2] , \thePAT/dmem/dmem[5][1] ,
         \thePAT/dmem/dmem[5][0] , \thePAT/dmem/dmem[6][7] ,
         \thePAT/dmem/dmem[6][6] , \thePAT/dmem/dmem[6][5] ,
         \thePAT/dmem/dmem[6][4] , \thePAT/dmem/dmem[6][3] ,
         \thePAT/dmem/dmem[6][2] , \thePAT/dmem/dmem[6][1] ,
         \thePAT/dmem/dmem[6][0] , \thePAT/dmem/dmem[7][7] ,
         \thePAT/dmem/dmem[7][6] , \thePAT/dmem/dmem[7][5] ,
         \thePAT/dmem/dmem[7][4] , \thePAT/dmem/dmem[7][3] ,
         \thePAT/dmem/dmem[7][2] , \thePAT/dmem/dmem[7][1] ,
         \thePAT/dmem/dmem[7][0] , \thePAT/dmem/dmem[8][7] ,
         \thePAT/dmem/dmem[8][6] , \thePAT/dmem/dmem[8][5] ,
         \thePAT/dmem/dmem[8][4] , \thePAT/dmem/dmem[8][3] ,
         \thePAT/dmem/dmem[8][2] , \thePAT/dmem/dmem[8][1] ,
         \thePAT/dmem/dmem[8][0] , \thePAT/dmem/dmem[9][7] ,
         \thePAT/dmem/dmem[9][6] , \thePAT/dmem/dmem[9][5] ,
         \thePAT/dmem/dmem[9][4] , \thePAT/dmem/dmem[9][3] ,
         \thePAT/dmem/dmem[9][2] , \thePAT/dmem/dmem[9][1] ,
         \thePAT/dmem/dmem[9][0] , \thePAT/dmem/dmem[10][7] ,
         \thePAT/dmem/dmem[10][6] , \thePAT/dmem/dmem[10][5] ,
         \thePAT/dmem/dmem[10][4] , \thePAT/dmem/dmem[10][3] ,
         \thePAT/dmem/dmem[10][2] , \thePAT/dmem/dmem[10][1] ,
         \thePAT/dmem/dmem[10][0] , \thePAT/dmem/dmem[11][7] ,
         \thePAT/dmem/dmem[11][6] , \thePAT/dmem/dmem[11][5] ,
         \thePAT/dmem/dmem[11][4] , \thePAT/dmem/dmem[11][3] ,
         \thePAT/dmem/dmem[11][2] , \thePAT/dmem/dmem[11][1] ,
         \thePAT/dmem/dmem[11][0] , \thePAT/dmem/dmem[12][7] ,
         \thePAT/dmem/dmem[12][6] , \thePAT/dmem/dmem[12][5] ,
         \thePAT/dmem/dmem[12][4] , \thePAT/dmem/dmem[12][3] ,
         \thePAT/dmem/dmem[12][2] , \thePAT/dmem/dmem[12][1] ,
         \thePAT/dmem/dmem[12][0] , \thePAT/dmem/dmem[13][7] ,
         \thePAT/dmem/dmem[13][6] , \thePAT/dmem/dmem[13][5] ,
         \thePAT/dmem/dmem[13][4] , \thePAT/dmem/dmem[13][3] ,
         \thePAT/dmem/dmem[13][2] , \thePAT/dmem/dmem[13][1] ,
         \thePAT/dmem/dmem[13][0] , \thePAT/dmem/dmem[14][7] ,
         \thePAT/dmem/dmem[14][6] , \thePAT/dmem/dmem[14][5] ,
         \thePAT/dmem/dmem[14][4] , \thePAT/dmem/dmem[14][3] ,
         \thePAT/dmem/dmem[14][2] , \thePAT/dmem/dmem[14][1] ,
         \thePAT/dmem/dmem[14][0] , \thePAT/dmem/dmem[15][7] ,
         \thePAT/dmem/dmem[15][6] , \thePAT/dmem/dmem[15][5] ,
         \thePAT/dmem/dmem[15][4] , \thePAT/dmem/dmem[15][3] ,
         \thePAT/dmem/dmem[15][2] , \thePAT/dmem/dmem[15][1] ,
         \thePAT/dmem/dmem[15][0] , \thePAT/n1 , \thePAT/z1 ,
         \thePAT/fieldp_history[0][4] , \thePAT/fieldp_history[0][3] ,
         \thePAT/fieldp_history[0][2] , \thePAT/fieldp_history[0][1] ,
         \thePAT/fieldp_history[0][0] , \thePAT/fieldp_history[1][4] ,
         \thePAT/fieldp_history[1][3] , \thePAT/fieldp_history[1][2] ,
         \thePAT/fieldp_history[1][1] , \thePAT/fieldp_history[1][0] ,
         \thePAT/fieldp_history[2][4] , \thePAT/fieldp_history[2][3] ,
         \thePAT/fieldp_history[2][2] , \thePAT/fieldp_history[2][1] ,
         \thePAT/fieldp_history[2][0] , \thePAT/fieldp_history[3][4] ,
         \thePAT/fieldp_history[3][3] , \thePAT/fieldp_history[3][2] ,
         \thePAT/fieldp_history[3][1] , \thePAT/fieldp_history[3][0] ,
         \thePAT/field_value[0] , \thePAT/field_value[1] ,
         \thePAT/field_value[2] , \thePAT/field_value[3] ,
         \thePAT/field_value[4] , \thePAT/field_value[5] ,
         \thePAT/field_value[6] , \thePAT/field_value[7] ,
         \thePAT/dest_field_regd , \thePAT/dest_acc_regd ,
         \thePAT/source_field_regd , \thePAT/op_mov_regd ,
         \thePAT/field_op_regd , \thePAT/N45 , \thePAT/N44 , \thePAT/N43 ,
         \thePAT/N42 , \thePAT/N41 , \thePAT/N40 , \thePAT/N39 , \thePAT/N38 ,
         \thePAT/condition_regd[1] , \thePAT/condition_regd[0] ,
         \thePAT/immediate_regd_2[7] , \thePAT/immediate_regd_2[6] ,
         \thePAT/immediate_regd_2[5] , \thePAT/immediate_regd_2[4] ,
         \thePAT/immediate_regd_2[3] , \thePAT/immediate_regd_2[2] ,
         \thePAT/immediate_regd_2[1] , \thePAT/immediate_regd_2[0] ,
         \thePAT/immediate_regd[0] , \thePAT/op_sub_subm_regd_2 ,
         \thePAT/op_add_addm_regd_2 , \thePAT/op_shlo_regd ,
         \thePAT/op_shl_regd , \thePAT/op_sub_subm_regd , \thePAT/op_not_regd ,
         \thePAT/op_and_regd , \thePAT/op_or_regd , \thePAT/field_alu_b[0] ,
         \thePAT/field_alu_b[1] , \thePAT/field_alu_b[2] ,
         \thePAT/field_alu_b[3] , \thePAT/field_alu_b[4] ,
         \thePAT/field_alu_b[5] , \thePAT/field_alu_b[6] ,
         \thePAT/field_alu_b[7] , \thePAT/acc_alu_b[0] , \thePAT/acc_alu_b[1] ,
         \thePAT/acc_alu_b[2] , \thePAT/acc_alu_b[3] , \thePAT/acc_alu_b[4] ,
         \thePAT/acc_alu_b[5] , \thePAT/acc_alu_b[6] , \thePAT/acc_alu_b[7] ,
         \thePAT/pc_immediate[0] , \thePAT/pc_immediate[1] ,
         \thePAT/pc_immediate[2] , \thePAT/pc_immediate[3] ,
         \thePAT/pc_immediate[4] , \thePAT/pc_immediate[5] ,
         \thePAT/pc_immediate[6] , \thePAT/pc_immediate[7] ,
         \thePAT/data_out[0] , \thePAT/data_out[1] , \thePAT/data_out[2] ,
         \thePAT/data_out[3] , \thePAT/data_out[4] , \thePAT/data_out[5] ,
         \thePAT/data_out[6] , \thePAT/data_out[7] , \thePAT/data_write ,
         \thePAT/data_write_adr[4] , \thePAT/data_write_adr[5] ,
         \thePAT/data_write_adr[6] , \thePAT/data_write_adr[7] ,
         \thePAT/data_read_adr[0] , \thePAT/data_read_adr[1] ,
         \thePAT/data_read_adr[2] , \thePAT/data_read_adr[3] ,
         \thePAT/dest_dmem , \thePAT/dest_field , \thePAT/dest_acc ,
         \thePAT/source_imm , \thePAT/op_mov , \thePAT/op_not ,
         \thePAT/op_setb , \thePAT/op_out , \thePAT/op_in , \thePAT/op_shr ,
         \thePAT/op_shlo , \thePAT/op_shl , \thePAT/op_and , \thePAT/op_or ,
         \thePAT/opcode_i0[1] , \thePAT/opcode_i0[2] , \thePAT/opcode_i0[3] ,
         \thePAT/opcode_i3[0] , \thePAT/opcode_i3[1] , \thePAT/opcode_i3[2] ,
         \thePAT/opcode_i3[3] , \thePAT/fieldp_next[4] ,
         \thePAT/fieldp_next[3] , \thePAT/fieldp_next[2] ,
         \thePAT/fieldp_next[1] , \thePAT/fieldp_next[0] ,
         \thePAT/condition[1] , \thePAT/opcode_i8[0] , \thePAT/opcode_i8[1] ,
         \thePAT/opcode_i8[2] , \thePAT/opcode_i8[3] ,
         \thePAT/immediate_i8[0] , \thePAT/immediate_i8[1] ,
         \thePAT/immediate_i8[2] , \thePAT/instruction_1[12] , \C1/DATA1_5 ,
         \C1/DATA1_4 , \C1/DATA1_3 , \thePAT/add_x_23/n69 ,
         \thePAT/add_x_23/n68 , \thePAT/add_x_23/n66 , \thePAT/add_x_23/n65 ,
         \thePAT/add_x_23/n64 , \thePAT/add_x_23/n63 , \thePAT/add_x_23/n60 ,
         \thePAT/add_x_23/n58 , \thePAT/add_x_23/n57 , \thePAT/add_x_23/n56 ,
         \thePAT/add_x_23/n55 , \thePAT/add_x_23/n54 , \thePAT/add_x_23/n53 ,
         \thePAT/add_x_23/n52 , \thePAT/add_x_23/n51 , \thePAT/add_x_23/n50 ,
         \thePAT/add_x_23/n49 , \thePAT/add_x_23/n48 , \thePAT/add_x_23/n47 ,
         \thePAT/add_x_23/n46 , \thePAT/add_x_23/n45 , \thePAT/add_x_23/n44 ,
         \thePAT/add_x_23/n40 , \thePAT/add_x_23/n39 , \thePAT/add_x_23/n36 ,
         \thePAT/add_x_23/n35 , \thePAT/add_x_23/n34 , \thePAT/add_x_23/n33 ,
         \thePAT/add_x_23/n32 , \thePAT/add_x_23/n31 , \thePAT/add_x_23/n28 ,
         \thePAT/add_x_23/n27 , \thePAT/add_x_23/n26 , \thePAT/add_x_23/n25 ,
         \thePAT/add_x_23/n24 , \thePAT/add_x_23/n23 , \thePAT/add_x_23/n22 ,
         \thePAT/add_x_23/n21 , \thePAT/add_x_23/n20 , \thePAT/add_x_23/n19 ,
         \thePAT/add_x_23/n18 , \thePAT/add_x_23/n17 , \thePAT/add_x_23/n15 ,
         \thePAT/add_x_23/n12 , \thePAT/add_x_23/n7 , \thePAT/add_x_23/n6 ,
         \thePAT/add_x_23/n4 , \thePAT/add_x_23/n2 , \thePAT/add_x_22/n32 ,
         \thePAT/add_x_22/n31 , \thePAT/add_x_22/n24 , \thePAT/add_x_22/n23 ,
         \thePAT/add_x_22/n15 , \thePAT/add_x_22/n14 , \thePAT/add_x_22/n13 ,
         \thePAT/add_x_22/n10 , \thePAT/add_x_22/n9 , \thePAT/add_x_22/n6 ,
         \thePAT/add_x_22/n5 , \thePAT/add_x_22/n4 , \DP_OP_108_135_5866/n67 ,
         \DP_OP_108_135_5866/n52 , \DP_OP_108_135_5866/n43 ,
         \DP_OP_108_135_5866/n42 , \DP_OP_108_135_5866/n39 ,
         \DP_OP_108_135_5866/n38 , \DP_OP_108_135_5866/n36 ,
         \DP_OP_108_135_5866/n33 , \DP_OP_108_135_5866/n32 ,
         \DP_OP_108_135_5866/n31 , \DP_OP_108_135_5866/n30 ,
         \DP_OP_108_135_5866/n28 , \DP_OP_108_135_5866/n27 ,
         \DP_OP_108_135_5866/n26 , \DP_OP_108_135_5866/n24 ,
         \DP_OP_108_135_5866/n23 , \DP_OP_108_135_5866/n22 ,
         \DP_OP_108_135_5866/n21 , \DP_OP_108_135_5866/n20 ,
         \DP_OP_108_135_5866/n19 , \DP_OP_108_135_5866/n17 ,
         \DP_OP_108_135_5866/n15 , \DP_OP_108_135_5866/n13 ,
         \DP_OP_108_135_5866/n12 , \DP_OP_108_135_5866/n11 ,
         \DP_OP_108_135_5866/n10 , \DP_OP_108_135_5866/n6 ,
         \DP_OP_108_135_5866/n4 , \DP_OP_108_135_5866/n3 ,
         \DP_OP_108_135_5866/n2 , \DP_OP_108_135_5866/n1 ,
         \DP_OP_104_132_4164/n47 , \DP_OP_104_132_4164/n46 ,
         \DP_OP_104_132_4164/n44 , \DP_OP_104_132_4164/n41 ,
         \DP_OP_104_132_4164/n39 , \DP_OP_104_132_4164/n38 ,
         \DP_OP_104_132_4164/n37 , \DP_OP_104_132_4164/n35 ,
         \DP_OP_104_132_4164/n34 , \DP_OP_104_132_4164/n33 ,
         \DP_OP_104_132_4164/n32 , \DP_OP_104_132_4164/n31 ,
         \DP_OP_104_132_4164/n29 , \DP_OP_104_132_4164/n28 ,
         \DP_OP_104_132_4164/n26 , \DP_OP_104_132_4164/n25 ,
         \DP_OP_104_132_4164/n24 , \DP_OP_104_132_4164/n23 ,
         \DP_OP_104_132_4164/n22 , \DP_OP_104_132_4164/n21 ,
         \DP_OP_104_132_4164/n18 , \DP_OP_104_132_4164/n16 ,
         \DP_OP_104_132_4164/n12 , \DP_OP_104_132_4164/n11 ,
         \DP_OP_104_132_4164/n8 , \DP_OP_104_132_4164/n7 ,
         \DP_OP_104_132_4164/n6 , \DP_OP_104_132_4164/n5 ,
         \DP_OP_104_132_4164/n4 , \DP_OP_104_132_4164/n3 , n1, n2, n3, n4, n5,
         n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20,
         n21, n22, n23, n24, n25, n26, n27, n28, n29, n30, n31, n32, n33, n34,
         n35, n36, n37, n38, n39, n40, n41, n42, n43, n44, n45, n46, n47, n48,
         n49, n50, n51, n52, n53, n54, n55, n56, n57, n58, n59, n60, n61, n62,
         n63, n64, n65, n66, n67, n68, n69, n70, n71, n72, n73, n74, n75, n76,
         n77, n78, n79, n80, n81, n82, n83, n84, n85, n86, n87, n88, n89, n90,
         n91, n92, n93, n94, n95, n96, n97, n98, n99, n100, n101, n102, n103,
         n104, n105, n106, n107, n108, n109, n110, n111, n112, n113, n114,
         n115, n116, n117, n118, n119, n120, n121, n122, n123, n124, n125,
         n126, n127, n128, n129, n130, n131, n133, n134, n135, n136, n137,
         n138, n139, n140, n141, n142, n143, n144, n145, n146, n147, n148,
         n149, n150, n151, n152, n153, n154, n155, n156, n157, n158, n159,
         n160, n162, n163, n164, n165, n166, n167, n168, n169, n170, n171,
         n172, n173, n174, n175, n176, n177, n178, n179, n180, n181, n182,
         n183, n184, n185, n186, n187, n188, n189, n190, n191, n192, n193,
         n194, n195, n196, n197, n198, n199, n200, n201, n202, n203, n204,
         n205, n206, n207, n208, n209, n210, n211, n212, n213, n214, n215,
         n216, n217, n218, n219, n220, n221, n222, n223, n224, n225, n226,
         n227, n228, n229, n230, n231, n232, n233, n234, n235, n236, n237,
         n238, n239, n240, n241, n243, n244, n245, n246, n247, n248, n249,
         n250, n251, n252, n253, n254, n255, n256, n257, n258, n259, n260,
         n261, n262, n263, n264, n265, n266, n267, n268, n269, n270, n271,
         n272, n273, n274, n275, n276, n277, n278, n279, n280, n281, n282,
         n283, n284, n285, n286, n287, n288, n289, n290, n292, n293, n294,
         n295, n296, n297, n298, n300, n301, n302, n303, n304, n305, n306,
         n307, n308, n309, n310, n311, n312, n313, n314, n315, n316, n317,
         n318, n319, n320, n321, n322, n323, n324, n325, n326, n327, n328,
         n329, n330, n331, n332, n333, n334, n335, n336, n337, n338, n339,
         n340, n341, n342, n343, n344, n345, n346, n347, n348, n349, n350,
         n351, n352, n353, n354, n355, n356, n357, n358, n359, n360, n361,
         n362, n363, n364, n365, n366, n367, n368, n369, n370, n371, n372,
         n373, n374, n375, n376, n377, n378, n379, n380, n381, n382, n383,
         n384, n385, n386, n387, n388, n389, n390, n391, n392, n393, n394,
         n395, n396, n397, n398, n399, n400, n401, n402, n403, n404, n405,
         n406, n407, n408, n409, n410, n411, n412, n413, n414, n415, n416,
         n417, n418, n419, n420, n421, n422, n423, n424, n425, n426, n427,
         n428, n429, n430, n431, n432, n433, n434, n435, n436, n437, n438,
         n439, n440, n441, n442, n443, n444, n445, n446, n447, n448, n449,
         n450, n451, n452, n453, n454, n455, n456, n457, n458, n459, n460,
         n461, n462, n463, n464, n465, n466, n467, n468, n469, n470, n471,
         n472, n473, n474, n475, n476, n477, n478, n479, n480, n481, n482,
         n483, n484, n485, n486, n487, n488, n489, n490, n491, n492, n493,
         n494, n495, n496, n497, n498, n499, n500, n501, n502, n503, n504,
         n505, n506, n507, n508, n509, n510, n511, n512, n513, n514, n515,
         n516, n517, n518, n519, n520, n521, n522, n523, n524, n525, n526,
         n527, n528, n529, n530, n531, n532, n533, n534, n535, n536, n537,
         n538, n539, n540, n541, n542, n543, n544, n545, n546, n547, n548,
         n549, n550, n551, n552, n553, n554, n555, n556, n557, n558, n559,
         n560, n561, n562, n563, n564, n565, n566, n567, n568, n569, n570,
         n571, n572, n573, n574, n575, n576, n577, n578, n579, n580, n581,
         n582, n583, n584, n585, n586, n587, n588, n589, n590, n591, n592,
         n593, n594, n595, n596, n597, n598, n599, n600, n601, n602, n603,
         n604, n605, n606, n607, n608, n609, n610, n611, n612, n613, n614,
         n615, n616, n617, n618, n619, n620, n621, n622, n623, n624, n625,
         n626, n627, n628, n629, n630, n631, n632, n633, n634, n635, n636,
         n637, n638, n639, n640, n641, n642, n643, n644, n645, n646, n647,
         n648, n649, n650, n651, n652, n653, n654, n655, n656, n657, n658,
         n659, n660, n661, n662, n663, n664, n665, n666, n667, n668, n669,
         n670, n671, n672, n673, n674, n675, n676, n677, n678, n679, n680,
         n681, n682, n683, n684, n686, n687, n688, n689, n690, n691, n692,
         n693, n694, n695, n696, n697, n698, n699, n700, n701, n702, n703,
         n704, n705, n706, n707, n708, n709, n710, n711, n712, n713, n714,
         n715, n716, n717, n718, n719, n720, n721, n722, n723, n724, n725,
         n726, n727, n728, n729, n730, n731, n732, n733, n734, n735, n736,
         n737, n738, n739, n740, n741, n742, n743, n744, n745, n746, n747,
         n748, n749, n750, n751, n752, n753, n754, n755, n756, n757, n758,
         n759, n760, n761, n762, n763, n764, n765, n766, n767, n768, n769,
         n770, n771, n772, n773, n774, n775, n776, n777, n778, n779, n780,
         n781, n782, n783, n784, n785, n786, n787, n788, n789, n790, n791,
         n792, n793, n794, n795, n796, n797, n798, n799, n800, n801, n802,
         n803, n804, n805, n806, n807, n808, n809, n810, n811, n812, n813,
         n814, n815, n816, n817, n818, n819, n820, n821, n822, n823, n824,
         n825, n826, n827, n828, n829, n830, n831, n832, n833, n834, n835,
         n836, n837, n838, n839, n840, n841, n842, n843, n844, n845, n846,
         n847, n848, n849, n850, n851, n852, n853, n854, n855, n856, n857,
         n858, n859, n860, n861, n862, n863, n864, n865, n866, n867, n868,
         n869, n870, n871, n872, n873, n874, n875, n876, n877, n878, n879,
         n880, n881, n882, n883, n884, n885, n886, n887, n888, n889, n890,
         n891, n892, n893, n894, n895, n896, n897, n898, n899, n900, n901,
         n902, n903, n904, n905, n906, n907, n908, n909, n910, n911, n912,
         n913, n914, n915, n916, n917, n918, n919, n920, n921, n922, n923,
         n924, n925, n926, n927, n928, n929, n930, n931, n932, n933, n934,
         n935, n936, n937, n938, n939, n940, n941, n942, n943, n944, n945,
         n946, n947, n948, n949, n950, n951, n952, n953, n954, n955, n956,
         n957, n958, n959, n960, n961, n962, n963, n964, n965, n966, n967,
         n968, n969, n970, n971, n972, n973, n974, n975, n976, n977, n978,
         n979, n980, n981, n982, n983, n984, n985, n986, n987, n988, n989,
         n990, n991, n992, n993, n994, n995, n996, n997, n998, n999, n1000,
         n1001, n1002, n1003, n1004, n1005, n1006, n1007, n1008, n1009, n1010,
         n1011, n1012, n1013, n1014, n1015, n1016, n1017, n1018, n1019, n1020,
         n1021, n1022, n1023, n1024, n1025, n1026, n1027, n1028, n1029, n1030,
         n1031, n1032, n1033, n1034, n1035, n1036, n1037, n1038, n1039, n1040,
         n1041, n1042, n1043, n1044, n1045, n1046, n1047, n1048, n1049, n1050,
         n1051, n1052, n1053, n1054, n1055, n1056, n1057, n1058, n1059, n1060,
         n1061, n1062, n1063, n1064, n1065, n1066, n1067, n1068, n1069, n1070,
         n1071, n1072, n1073, n1074, n1075, n1076, n1077, n1078, n1079, n1080,
         n1081, n1082, n1083, n1084, n1085, n1086, n1087, n1088, n1089, n1090,
         n1091, n1092, n1093, n1094, n1095, n1096, n1097, n1098, n1099, n1100,
         n1101, n1102, n1103, n1104, n1105, n1106, n1107, n1108, n1109, n1110,
         n1111, n1112, n1113, n1114, n1115, n1116, n1117, n1118, n1119, n1120,
         n1121, n1122, n1123, n1124, n1125, n1126, n1127, n1128, n1129, n1130,
         n1131, n1132, n1133, n1134, n1135, n1136, n1137, n1138, n1139, n1140,
         n1141, n1142, n1143, n1144, n1145, n1146, n1147, n1148, n1149, n1150,
         n1151, n1152, n1153, n1154, n1155, n1156, n1157, n1158, n1159, n1160,
         n1161, n1162, n1163, n1164, n1165, n1166, n1167, n1168, n1169, n1170,
         n1171, n1172, n1173, n1174, n1175, n1176, n1177, n1178, n1179, n1180,
         n1181, n1182, n1183, n1184, n1185, n1186, n1187, n1188, n1189, n1190,
         n1191, n1192, n1193, n1194, n1195, n1196, n1197, n1198, n1199, n1200,
         n1201, n1202, n1203, n1204, n1205, n1206, n1207, n1208, n1209, n1210,
         n1211, n1212, n1213, n1214, n1215, n1216, n1217, n1218, n1219, n1220,
         n1221, n1222, n1223, n1224, n1225, n1226, n1227, n1228, n1229, n1230,
         n1231, n1232, n1233, n1234, n1235, n1236, n1237, n1238, n1239, n1240,
         n1241, n1242, n1243, n1244, n1245, n1246, n1247, n1248, n1249, n1250,
         n1251, n1252, n1253, n1254, n1255, n1256, n1257, n1258, n1259, n1260,
         n1261, n1262, n1263, n1264, n1265, n1266, n1267, n1268, n1269, n1270,
         n1271, n1272, n1273, n1274, n1275, n1276, n1277, n1278, n1279, n1280,
         n1281, n1282, n1283, n1284, n1285, n1286, n1287, n1288, n1289, n1290,
         n1291, n1292, n1293, n1294, n1295, n1296, n1297, n1298, n1299, n1300,
         n1301, n1302, n1303, n1304, n1305, n1306, n1307, n1308, n1309, n1310,
         n1311, n1312, n1313, n1314, n1315, n1316, n1317, n1318, n1319, n1320,
         n1321, n1322, n1323, n1324, n1325, n1326, n1327, n1328, n1329, n1330,
         n1331, n1332, n1333, n1334, n1335, n1336, n1337, n1338, n1339, n1340,
         n1341, n1342, n1343, n1344, n1345, n1346, n1347, n1348, n1349, n1350,
         n1351, n1352, n1353, n1354, n1355, n1356, n1357, n1358, n1359, n1360,
         n1361, n1362, n1363, n1364, n1365, n1366, n1367, n1368, n1369, n1370,
         n1371, n1372, n1373, n1374, n1375, n1376, n1377, n1378, n1379, n1380,
         n1381, n1382, n1383, n1384, n1385, n1387, n1389, n1390, n1391, n1392,
         n1393, n1394, n1395, n1396, n1397, n1398, n1399, n1400, n1401, n1402,
         n1403, n1404, n1405, n1406, n1407, n1408, n1409, n1410, n1411, n1412,
         n1413, n1414, n1415, n1416, n1417, n1418, n1419, n1420, n1421, n1422,
         n1423, n1424, n1425, n1426, n1427, n1428, n1429, n1430, n1431, n1432,
         n1433, n1434, n1435, n1436, n1437, n1438, n1439, n1440, n1441, n1442,
         n1443, n1444, n1445, n1446, n1447, n1448, n1449, n1450, n1451, n1452,
         n1453, n1454, n1455, n1456, n1457, n1458, n1459, n1460, n1461, n1462,
         n1463, n1464, n1465, n1466, n1467, n1468, n1469, n1470, n1471, n1472,
         n1473, n1474, n1475, n1476, n1477, n1478, n1479, n1480, n1481, n1482,
         n1483, n1484, n1485, n1486, n1487, n1488, n1489, n1490, n1491, n1492,
         n1493, n1494, n1495, n1496, n1497, n1498, n1499, n1500, n1501, n1502,
         n1503, n1504, n1505, n1506, n1507, n1508, n1509, n1510, n1511, n1512,
         n1513, n1514, n1515, n1516, n1517, n1518, n1519, n1520, n1521, n1522,
         n1523, n1524, n1525, n1526, n1527, n1529, n1530, n1531, n1532, n1533,
         n1534, n1535, n1536, n1537, n1538, n1539, n1540, n1541, n1542, n1543,
         n1544, n1545, n1546, n1547, n1548, n1549, n1550, n1551, n1552, n1553,
         n1554, n1555, n1556, n1557, n1558, n1559, n1560, n1561, n1562, n1563,
         n1564, n1565, n1566, n1567, n1568;
  wire   [7:0] acc_out;
  wire   [7:0] buf_fieldp;
  wire   [4:0] buf_fieldwp;
  wire   [19:0] instruction;
  wire   [7:0] field_in;
  wire   [7:0] field_out;
  tri   [9:0] imem_write_adr;
  tri   imem_write;
  tri   [39:0] imem_in;
  tri   [9:0] pc;
  tri   \iBuffer/imem_out[39] ;
  tri   \iBuffer/imem_out[38] ;
  tri   \iBuffer/imem_out[37] ;
  tri   \iBuffer/imem_out[36] ;
  tri   \iBuffer/imem_out[35] ;
  tri   \iBuffer/imem_out[34] ;
  tri   \iBuffer/imem_out[33] ;
  tri   \iBuffer/imem_out[32] ;
  tri   \iBuffer/imem_out[31] ;
  tri   \iBuffer/imem_out[30] ;
  tri   \iBuffer/imem_out[29] ;
  tri   \iBuffer/imem_out[28] ;
  tri   \iBuffer/imem_out[27] ;
  tri   \iBuffer/imem_out[26] ;
  tri   \iBuffer/imem_out[25] ;
  tri   \iBuffer/imem_out[24] ;
  tri   \iBuffer/imem_out[23] ;
  tri   \iBuffer/imem_out[22] ;
  tri   \iBuffer/imem_out[21] ;
  tri   \iBuffer/imem_out[20] ;
  tri   \iBuffer/imem_out[19] ;
  tri   \iBuffer/imem_out[18] ;
  tri   \iBuffer/imem_out[17] ;
  tri   \iBuffer/imem_out[16] ;
  tri   \iBuffer/imem_out[15] ;
  tri   \iBuffer/imem_out[14] ;
  tri   \iBuffer/imem_out[13] ;
  tri   \iBuffer/imem_out[12] ;
  tri   \iBuffer/imem_out[11] ;
  tri   \iBuffer/imem_out[10] ;
  tri   \iBuffer/imem_out[9] ;
  tri   \iBuffer/imem_out[8] ;
  tri   \iBuffer/imem_out[7] ;
  tri   \iBuffer/imem_out[6] ;
  tri   \iBuffer/imem_out[5] ;
  tri   \iBuffer/imem_out[4] ;
  tri   \iBuffer/imem_out[3] ;
  tri   \iBuffer/imem_out[2] ;
  tri   \iBuffer/imem_out[1] ;
  tri   \iBuffer/imem_out[0] ;
  tri   n1528;

  patternbuffer dummyPatBuf ( .buf_fieldp(buf_fieldp), .buf_fieldwp({
        buf_fieldp[7:5], buf_fieldwp}), .field_write_en(field_write_en), 
        .field_out(field_in), .field_in(field_out) );
  DFX2_HV \iBuffer/i_buffer_reg[1][0]  ( .D(\iBuffer/n1 ), .CP(clk), .Q(
        \iBuffer/i_buffer[1][0] ), .QN(n1529) );
  DFX2_HV \iBuffer/i_buffer_reg[1][1]  ( .D(\iBuffer/n2 ), .CP(clk), .Q(
        \iBuffer/i_buffer[1][1] ), .QN(n1530) );
  DFX2_HV \iBuffer/i_buffer_reg[1][2]  ( .D(\iBuffer/n3 ), .CP(clk), .Q(
        \iBuffer/i_buffer[1][2] ), .QN(n1531) );
  DFX2_HV \iBuffer/i_buffer_reg[1][3]  ( .D(\iBuffer/n4 ), .CP(clk), .Q(
        \iBuffer/i_buffer[1][3] ), .QN(n1532) );
  DFX2_HV \iBuffer/instruction_out_reg[4]  ( .D(\iBuffer/N35 ), .CP(clk), .Q(
        instruction[4]) );
  DFX2_HV \iBuffer/i_buffer_reg[1][4]  ( .D(\iBuffer/n5 ), .CP(clk), .Q(
        \iBuffer/i_buffer[1][4] ), .QN(n1533) );
  DFX2_HV \iBuffer/i_buffer_reg[1][5]  ( .D(\iBuffer/n6 ), .CP(clk), .Q(
        \iBuffer/i_buffer[1][5] ), .QN(n1534) );
  DFX2_HV \iBuffer/i_buffer_reg[1][6]  ( .D(\iBuffer/n7 ), .CP(clk), .Q(
        \iBuffer/i_buffer[1][6] ), .QN(n1535) );
  DFX2_HV \iBuffer/i_buffer_reg[1][7]  ( .D(\iBuffer/n8 ), .CP(clk), .Q(
        \iBuffer/i_buffer[1][7] ), .QN(n1536) );
  DFX2_HV \iBuffer/i_buffer_reg[1][8]  ( .D(\iBuffer/n9 ), .CP(clk), .Q(
        \iBuffer/i_buffer[1][8] ), .QN(n1537) );
  DFX2_HV \iBuffer/i_buffer_reg[1][9]  ( .D(\iBuffer/n10 ), .CP(clk), .Q(
        \iBuffer/i_buffer[1][9] ), .QN(n1538) );
  DFX2_HV \iBuffer/instruction_out_reg[10]  ( .D(\iBuffer/N41 ), .CP(clk), .Q(
        instruction[10]) );
  DFX2_HV \iBuffer/i_buffer_reg[1][10]  ( .D(\iBuffer/n11 ), .CP(clk), .Q(
        \iBuffer/i_buffer[1][10] ), .QN(n1539) );
  DFX2_HV \iBuffer/i_buffer_reg[1][11]  ( .D(\iBuffer/n12 ), .CP(clk), .Q(
        \iBuffer/i_buffer[1][11] ), .QN(n1540) );
  DFX2_HV \iBuffer/instruction_out_reg[12]  ( .D(\iBuffer/N43 ), .CP(clk), .Q(
        instruction[12]) );
  DFX2_HV \iBuffer/i_buffer_reg[1][12]  ( .D(\iBuffer/n13 ), .CP(clk), .Q(
        \iBuffer/i_buffer[1][12] ), .QN(n1541) );
  DFX2_HV \iBuffer/instruction_out_reg[13]  ( .D(\iBuffer/N44 ), .CP(clk), .Q(
        instruction[13]) );
  DFX2_HV \iBuffer/i_buffer_reg[1][13]  ( .D(\iBuffer/n14 ), .CP(clk), .Q(
        \iBuffer/i_buffer[1][13] ), .QN(n1542) );
  DFX2_HV \iBuffer/instruction_out_reg[14]  ( .D(\iBuffer/N45 ), .CP(clk), .Q(
        instruction[14]) );
  DFX2_HV \iBuffer/i_buffer_reg[1][14]  ( .D(\iBuffer/n15 ), .CP(clk), .Q(
        \iBuffer/i_buffer[1][14] ), .QN(n1543) );
  DFX2_HV \iBuffer/instruction_out_reg[15]  ( .D(\iBuffer/N46 ), .CP(clk), .Q(
        instruction[15]) );
  DFX2_HV \iBuffer/i_buffer_reg[1][15]  ( .D(\iBuffer/n16 ), .CP(clk), .Q(
        \iBuffer/i_buffer[1][15] ), .QN(n1544) );
  DFX2_HV \iBuffer/instruction_out_reg[16]  ( .D(\iBuffer/N47 ), .CP(clk), .Q(
        instruction[16]) );
  DFX2_HV \iBuffer/i_buffer_reg[1][16]  ( .D(\iBuffer/n17 ), .CP(clk), .Q(
        \iBuffer/i_buffer[1][16] ), .QN(n1545) );
  DFX2_HV \iBuffer/instruction_out_reg[17]  ( .D(\iBuffer/N48 ), .CP(clk), .Q(
        instruction[17]) );
  DFX2_HV \iBuffer/i_buffer_reg[1][17]  ( .D(\iBuffer/n18 ), .CP(clk), .Q(
        \iBuffer/i_buffer[1][17] ), .QN(n1546) );
  DFX2_HV \iBuffer/instruction_out_reg[18]  ( .D(\iBuffer/N49 ), .CP(clk), .Q(
        instruction[18]) );
  DFX2_HV \iBuffer/i_buffer_reg[1][18]  ( .D(\iBuffer/n19 ), .CP(clk), .Q(
        \iBuffer/i_buffer[1][18] ), .QN(n1547) );
  DFX2_HV \iBuffer/instruction_out_reg[19]  ( .D(\iBuffer/N50 ), .CP(clk), .Q(
        instruction[19]) );
  DFX2_HV \iBuffer/i_buffer_reg[1][19]  ( .D(\iBuffer/n20 ), .CP(clk), .Q(
        \iBuffer/i_buffer[1][19] ), .QN(n1548) );
  DFX2_HV \iBuffer/i_buffer_reg[0][0]  ( .D(\iBuffer/n21 ), .CP(clk), .Q(
        \iBuffer/i_buffer[0][0] ), .QN(n1549) );
  DFX2_HV \iBuffer/i_buffer_reg[0][1]  ( .D(\iBuffer/n22 ), .CP(clk), .Q(
        \iBuffer/i_buffer[0][1] ), .QN(n1550) );
  DFX2_HV \iBuffer/i_buffer_reg[0][2]  ( .D(\iBuffer/n23 ), .CP(clk), .Q(
        \iBuffer/i_buffer[0][2] ), .QN(n1551) );
  DFX2_HV \iBuffer/i_buffer_reg[0][3]  ( .D(\iBuffer/n24 ), .CP(clk), .Q(
        \iBuffer/i_buffer[0][3] ), .QN(n1552) );
  DFX2_HV \iBuffer/i_buffer_reg[0][4]  ( .D(\iBuffer/n25 ), .CP(clk), .Q(
        \iBuffer/i_buffer[0][4] ), .QN(n1553) );
  DFX2_HV \iBuffer/i_buffer_reg[0][5]  ( .D(\iBuffer/n26 ), .CP(clk), .Q(
        \iBuffer/i_buffer[0][5] ), .QN(n1554) );
  DFX2_HV \iBuffer/i_buffer_reg[0][6]  ( .D(\iBuffer/n27 ), .CP(clk), .Q(
        \iBuffer/i_buffer[0][6] ), .QN(n1555) );
  DFX2_HV \iBuffer/i_buffer_reg[0][7]  ( .D(\iBuffer/n28 ), .CP(clk), .Q(
        \iBuffer/i_buffer[0][7] ), .QN(n1556) );
  DFX2_HV \iBuffer/i_buffer_reg[0][8]  ( .D(\iBuffer/n29 ), .CP(clk), .Q(
        \iBuffer/i_buffer[0][8] ), .QN(n1557) );
  DFX2_HV \iBuffer/i_buffer_reg[0][9]  ( .D(\iBuffer/n30 ), .CP(clk), .Q(
        \iBuffer/i_buffer[0][9] ), .QN(n1558) );
  DFX2_HV \iBuffer/i_buffer_reg[0][10]  ( .D(\iBuffer/n31 ), .CP(clk), .Q(
        \iBuffer/i_buffer[0][10] ), .QN(n1559) );
  DFX2_HV \iBuffer/i_buffer_reg[0][11]  ( .D(\iBuffer/n32 ), .CP(clk), .Q(
        \iBuffer/i_buffer[0][11] ), .QN(n1560) );
  DFX2_HV \iBuffer/i_buffer_reg[0][12]  ( .D(\iBuffer/n33 ), .CP(clk), .Q(
        \iBuffer/i_buffer[0][12] ), .QN(n1561) );
  DFX2_HV \iBuffer/i_buffer_reg[0][13]  ( .D(\iBuffer/n34 ), .CP(clk), .Q(
        \iBuffer/i_buffer[0][13] ), .QN(n1562) );
  DFX2_HV \iBuffer/i_buffer_reg[0][14]  ( .D(\iBuffer/n35 ), .CP(clk), .Q(
        \iBuffer/i_buffer[0][14] ), .QN(n1563) );
  DFX2_HV \iBuffer/i_buffer_reg[0][15]  ( .D(\iBuffer/n36 ), .CP(clk), .Q(
        \iBuffer/i_buffer[0][15] ), .QN(n1564) );
  DFX2_HV \iBuffer/i_buffer_reg[0][16]  ( .D(\iBuffer/n37 ), .CP(clk), .Q(
        \iBuffer/i_buffer[0][16] ), .QN(n1565) );
  DFX2_HV \iBuffer/i_buffer_reg[0][17]  ( .D(\iBuffer/n38 ), .CP(clk), .Q(
        \iBuffer/i_buffer[0][17] ), .QN(n1566) );
  DFX2_HV \iBuffer/i_buffer_reg[0][18]  ( .D(\iBuffer/n39 ), .CP(clk), .Q(
        \iBuffer/i_buffer[0][18] ), .QN(n1567) );
  DFX2_HV \iBuffer/i_buffer_reg[0][19]  ( .D(\iBuffer/n40 ), .CP(clk), .Q(
        \iBuffer/i_buffer[0][19] ), .QN(n1568) );
  DFX2_HV \iBuffer/jump_bubble_reg[1]  ( .D(\iBuffer/n63 ), .CP(clk), .Q(
        \iBuffer/jump_bubble[1] ) );
  DFX2_HV \iBuffer/jump_bubble_reg[0]  ( .D(\iBuffer/n64 ), .CP(clk), .Q(
        \iBuffer/jump_bubble[0] ), .QN(n320) );
  inst_mem \iBuffer/iMem  ( .p1({n1528, pc[9:1]}), .p2(imem_write_adr), .p3(
        imem_write), .p4(imem_in), .p5({\iBuffer/imem_out[39] , 
        \iBuffer/imem_out[38] , \iBuffer/imem_out[37] , \iBuffer/imem_out[36] , 
        \iBuffer/imem_out[35] , \iBuffer/imem_out[34] , \iBuffer/imem_out[33] , 
        \iBuffer/imem_out[32] , \iBuffer/imem_out[31] , \iBuffer/imem_out[30] , 
        \iBuffer/imem_out[29] , \iBuffer/imem_out[28] , \iBuffer/imem_out[27] , 
        \iBuffer/imem_out[26] , \iBuffer/imem_out[25] , \iBuffer/imem_out[24] , 
        \iBuffer/imem_out[23] , \iBuffer/imem_out[22] , \iBuffer/imem_out[21] , 
        \iBuffer/imem_out[20] , \iBuffer/imem_out[19] , \iBuffer/imem_out[18] , 
        \iBuffer/imem_out[17] , \iBuffer/imem_out[16] , \iBuffer/imem_out[15] , 
        \iBuffer/imem_out[14] , \iBuffer/imem_out[13] , \iBuffer/imem_out[12] , 
        \iBuffer/imem_out[11] , \iBuffer/imem_out[10] , \iBuffer/imem_out[9] , 
        \iBuffer/imem_out[8] , \iBuffer/imem_out[7] , \iBuffer/imem_out[6] , 
        \iBuffer/imem_out[5] , \iBuffer/imem_out[4] , \iBuffer/imem_out[3] , 
        \iBuffer/imem_out[2] , \iBuffer/imem_out[1] , \iBuffer/imem_out[0] })
         );
  DFX2_HV \thePAT/thePC/pc_out_reg[3]  ( .D(\thePAT/n12 ), .CP(clk), .Q(pc[3])
         );
  DFX2_HV \thePAT/thePC/pc_out_reg[2]  ( .D(\thePAT/n13 ), .CP(clk), .Q(pc[2])
         );
  DFX2_HV \thePAT/thePC/pc_out_reg[1]  ( .D(\thePAT/n14 ), .CP(clk), .Q(pc[1])
         );
  DFX2_HV \thePAT/dmem/dmem_reg[0][7]  ( .D(\thePAT/n636 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[0][7] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[0][6]  ( .D(\thePAT/n637 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[0][6] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[0][5]  ( .D(\thePAT/n638 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[0][5] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[0][4]  ( .D(\thePAT/n639 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[0][4] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[0][3]  ( .D(\thePAT/n640 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[0][3] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[0][2]  ( .D(\thePAT/n641 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[0][2] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[0][1]  ( .D(\thePAT/n642 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[0][1] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[0][0]  ( .D(\thePAT/n643 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[0][0] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[1][7]  ( .D(\thePAT/n644 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[1][7] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[1][6]  ( .D(\thePAT/n645 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[1][6] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[1][5]  ( .D(\thePAT/n646 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[1][5] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[1][4]  ( .D(\thePAT/n647 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[1][4] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[1][3]  ( .D(\thePAT/n648 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[1][3] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[1][2]  ( .D(\thePAT/n649 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[1][2] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[1][1]  ( .D(\thePAT/n650 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[1][1] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[1][0]  ( .D(\thePAT/n651 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[1][0] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[2][7]  ( .D(\thePAT/n652 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[2][7] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[2][6]  ( .D(\thePAT/n653 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[2][6] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[2][5]  ( .D(\thePAT/n654 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[2][5] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[2][4]  ( .D(\thePAT/n655 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[2][4] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[2][3]  ( .D(\thePAT/n656 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[2][3] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[2][2]  ( .D(\thePAT/n657 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[2][2] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[2][1]  ( .D(\thePAT/n658 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[2][1] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[2][0]  ( .D(\thePAT/n659 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[2][0] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[3][7]  ( .D(\thePAT/n660 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[3][7] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[3][6]  ( .D(\thePAT/n661 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[3][6] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[3][5]  ( .D(\thePAT/n662 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[3][5] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[3][4]  ( .D(\thePAT/n663 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[3][4] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[3][3]  ( .D(\thePAT/n664 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[3][3] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[3][2]  ( .D(\thePAT/n665 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[3][2] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[3][1]  ( .D(\thePAT/n666 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[3][1] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[3][0]  ( .D(\thePAT/n667 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[3][0] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[4][7]  ( .D(\thePAT/n668 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[4][7] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[4][6]  ( .D(\thePAT/n669 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[4][6] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[4][5]  ( .D(\thePAT/n670 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[4][5] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[4][4]  ( .D(\thePAT/n671 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[4][4] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[4][3]  ( .D(\thePAT/n672 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[4][3] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[4][2]  ( .D(\thePAT/n673 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[4][2] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[4][1]  ( .D(\thePAT/n674 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[4][1] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[4][0]  ( .D(\thePAT/n675 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[4][0] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[5][7]  ( .D(\thePAT/n676 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[5][7] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[5][6]  ( .D(\thePAT/n677 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[5][6] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[5][5]  ( .D(\thePAT/n678 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[5][5] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[5][4]  ( .D(\thePAT/n679 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[5][4] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[5][3]  ( .D(\thePAT/n680 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[5][3] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[5][2]  ( .D(\thePAT/n681 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[5][2] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[5][1]  ( .D(\thePAT/n682 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[5][1] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[5][0]  ( .D(\thePAT/n683 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[5][0] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[6][7]  ( .D(\thePAT/n684 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[6][7] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[6][6]  ( .D(\thePAT/n685 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[6][6] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[6][5]  ( .D(\thePAT/n686 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[6][5] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[6][4]  ( .D(\thePAT/n687 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[6][4] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[6][3]  ( .D(\thePAT/n688 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[6][3] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[6][2]  ( .D(\thePAT/n689 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[6][2] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[6][1]  ( .D(\thePAT/n690 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[6][1] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[6][0]  ( .D(\thePAT/n691 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[6][0] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[7][7]  ( .D(\thePAT/n692 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[7][7] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[7][6]  ( .D(\thePAT/n693 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[7][6] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[7][5]  ( .D(\thePAT/n694 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[7][5] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[7][4]  ( .D(\thePAT/n695 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[7][4] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[7][3]  ( .D(\thePAT/n696 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[7][3] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[7][2]  ( .D(\thePAT/n697 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[7][2] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[7][1]  ( .D(\thePAT/n698 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[7][1] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[7][0]  ( .D(\thePAT/n699 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[7][0] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[8][7]  ( .D(\thePAT/n700 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[8][7] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[8][6]  ( .D(\thePAT/n701 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[8][6] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[8][5]  ( .D(\thePAT/n702 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[8][5] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[8][4]  ( .D(\thePAT/n703 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[8][4] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[8][3]  ( .D(\thePAT/n704 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[8][3] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[8][2]  ( .D(\thePAT/n705 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[8][2] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[8][1]  ( .D(\thePAT/n706 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[8][1] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[8][0]  ( .D(\thePAT/n707 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[8][0] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[9][7]  ( .D(\thePAT/n708 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[9][7] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[9][6]  ( .D(\thePAT/n709 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[9][6] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[9][5]  ( .D(\thePAT/n710 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[9][5] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[9][4]  ( .D(\thePAT/n711 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[9][4] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[9][3]  ( .D(\thePAT/n712 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[9][3] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[9][2]  ( .D(\thePAT/n713 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[9][2] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[9][1]  ( .D(\thePAT/n714 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[9][1] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[9][0]  ( .D(\thePAT/n715 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[9][0] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[10][7]  ( .D(\thePAT/n716 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[10][7] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[10][6]  ( .D(\thePAT/n717 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[10][6] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[10][5]  ( .D(\thePAT/n718 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[10][5] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[10][4]  ( .D(\thePAT/n719 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[10][4] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[10][3]  ( .D(\thePAT/n720 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[10][3] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[10][2]  ( .D(\thePAT/n721 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[10][2] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[10][1]  ( .D(\thePAT/n722 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[10][1] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[10][0]  ( .D(\thePAT/n723 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[10][0] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[11][7]  ( .D(\thePAT/n724 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[11][7] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[11][6]  ( .D(\thePAT/n725 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[11][6] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[11][5]  ( .D(\thePAT/n726 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[11][5] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[11][4]  ( .D(\thePAT/n727 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[11][4] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[11][3]  ( .D(\thePAT/n728 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[11][3] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[11][2]  ( .D(\thePAT/n729 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[11][2] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[11][1]  ( .D(\thePAT/n730 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[11][1] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[11][0]  ( .D(\thePAT/n731 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[11][0] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[12][7]  ( .D(\thePAT/n732 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[12][7] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[12][6]  ( .D(\thePAT/n733 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[12][6] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[12][5]  ( .D(\thePAT/n734 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[12][5] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[12][4]  ( .D(\thePAT/n735 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[12][4] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[12][3]  ( .D(\thePAT/n736 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[12][3] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[12][2]  ( .D(\thePAT/n737 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[12][2] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[12][1]  ( .D(\thePAT/n738 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[12][1] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[12][0]  ( .D(\thePAT/n739 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[12][0] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[13][7]  ( .D(\thePAT/n740 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[13][7] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[13][6]  ( .D(\thePAT/n741 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[13][6] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[13][5]  ( .D(\thePAT/n742 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[13][5] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[13][4]  ( .D(\thePAT/n743 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[13][4] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[13][3]  ( .D(\thePAT/n744 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[13][3] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[13][2]  ( .D(\thePAT/n745 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[13][2] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[13][1]  ( .D(\thePAT/n746 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[13][1] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[13][0]  ( .D(\thePAT/n747 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[13][0] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[14][7]  ( .D(\thePAT/n748 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[14][7] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[14][6]  ( .D(\thePAT/n749 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[14][6] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[14][5]  ( .D(\thePAT/n750 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[14][5] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[14][4]  ( .D(\thePAT/n751 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[14][4] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[14][3]  ( .D(\thePAT/n752 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[14][3] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[14][2]  ( .D(\thePAT/n753 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[14][2] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[14][1]  ( .D(\thePAT/n754 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[14][1] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[14][0]  ( .D(\thePAT/n755 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[14][0] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[15][7]  ( .D(\thePAT/n756 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[15][7] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[15][6]  ( .D(\thePAT/n757 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[15][6] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[15][5]  ( .D(\thePAT/n758 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[15][5] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[15][4]  ( .D(\thePAT/n759 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[15][4] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[15][3]  ( .D(\thePAT/n760 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[15][3] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[15][2]  ( .D(\thePAT/n761 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[15][2] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[15][1]  ( .D(\thePAT/n762 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[15][1] ) );
  DFX2_HV \thePAT/dmem/dmem_reg[15][0]  ( .D(\thePAT/n763 ), .CP(clk), .Q(
        \thePAT/dmem/dmem[15][0] ) );
  DFX2_HV \thePAT/outputs_reg[0]  ( .D(\thePAT/n793 ), .CP(clk), .Q(outputs[0]), .QN(n335) );
  DFX2_HV \thePAT/outputs_reg[1]  ( .D(\thePAT/n791 ), .CP(clk), .Q(outputs[1]), .QN(n334) );
  DFX2_HV \thePAT/outputs_reg[2]  ( .D(\thePAT/n789 ), .CP(clk), .Q(outputs[2]), .QN(n333) );
  DFX2_HV \thePAT/outputs_reg[3]  ( .D(\thePAT/n787 ), .CP(clk), .Q(outputs[3]), .QN(n332) );
  DFX2_HV \thePAT/outputs_reg[4]  ( .D(\thePAT/n785 ), .CP(clk), .Q(outputs[4]), .QN(n331) );
  DFX2_HV \thePAT/outputs_reg[5]  ( .D(\thePAT/n783 ), .CP(clk), .Q(outputs[5]), .QN(n330) );
  DFX2_HV \thePAT/outputs_reg[6]  ( .D(\thePAT/n780 ), .CP(clk), .Q(outputs[6]) );
  DFX2_HV \thePAT/bufp_reg[2]  ( .D(\thePAT/n805 ), .CP(clk), .Q(buf_fieldp[7]) );
  DFX2_HV \thePAT/bufp_reg[1]  ( .D(\thePAT/n806 ), .CP(clk), .Q(buf_fieldp[6]) );
  DFX2_HV \thePAT/field_write_en_reg  ( .D(\thePAT/n809 ), .CP(clk), .Q(
        field_write_en) );
  DFX2_HV \thePAT/fieldwp_reg[0]  ( .D(\thePAT/fieldp_history[3][0] ), .CP(clk), .Q(buf_fieldwp[0]) );
  DFX2_HV \thePAT/fieldwp_reg[1]  ( .D(\thePAT/fieldp_history[3][1] ), .CP(clk), .Q(buf_fieldwp[1]) );
  DFX2_HV \thePAT/fieldwp_reg[2]  ( .D(\thePAT/fieldp_history[3][2] ), .CP(clk), .Q(buf_fieldwp[2]) );
  DFX2_HV \thePAT/fieldwp_reg[3]  ( .D(\thePAT/fieldp_history[3][3] ), .CP(clk), .Q(buf_fieldwp[3]) );
  DFX2_HV \thePAT/fieldwp_reg[4]  ( .D(\thePAT/fieldp_history[3][4] ), .CP(clk), .Q(buf_fieldwp[4]) );
  DFX2_HV \thePAT/fieldp_history_reg[3][0]  ( .D(\thePAT/fieldp_history[2][0] ), .CP(clk), .Q(\thePAT/fieldp_history[3][0] ) );
  DFX2_HV \thePAT/fieldp_history_reg[3][1]  ( .D(\thePAT/fieldp_history[2][1] ), .CP(clk), .Q(\thePAT/fieldp_history[3][1] ) );
  DFX2_HV \thePAT/fieldp_history_reg[3][2]  ( .D(\thePAT/fieldp_history[2][2] ), .CP(clk), .Q(\thePAT/fieldp_history[3][2] ) );
  DFX2_HV \thePAT/fieldp_history_reg[3][3]  ( .D(\thePAT/fieldp_history[2][3] ), .CP(clk), .Q(\thePAT/fieldp_history[3][3] ) );
  DFX2_HV \thePAT/fieldp_history_reg[3][4]  ( .D(\thePAT/fieldp_history[2][4] ), .CP(clk), .Q(\thePAT/fieldp_history[3][4] ) );
  DFX2_HV \thePAT/fieldp_history_reg[2][0]  ( .D(\thePAT/fieldp_history[1][0] ), .CP(clk), .Q(\thePAT/fieldp_history[2][0] ) );
  DFX2_HV \thePAT/fieldp_history_reg[2][1]  ( .D(\thePAT/fieldp_history[1][1] ), .CP(clk), .Q(\thePAT/fieldp_history[2][1] ) );
  DFX2_HV \thePAT/fieldp_history_reg[2][2]  ( .D(\thePAT/fieldp_history[1][2] ), .CP(clk), .Q(\thePAT/fieldp_history[2][2] ) );
  DFX2_HV \thePAT/fieldp_history_reg[2][3]  ( .D(\thePAT/fieldp_history[1][3] ), .CP(clk), .Q(\thePAT/fieldp_history[2][3] ) );
  DFX2_HV \thePAT/fieldp_history_reg[2][4]  ( .D(\thePAT/fieldp_history[1][4] ), .CP(clk), .Q(\thePAT/fieldp_history[2][4] ) );
  DFX2_HV \thePAT/fieldp_history_reg[1][0]  ( .D(\thePAT/fieldp_history[0][0] ), .CP(clk), .Q(\thePAT/fieldp_history[1][0] ) );
  DFX2_HV \thePAT/fieldp_history_reg[1][1]  ( .D(\thePAT/fieldp_history[0][1] ), .CP(clk), .Q(\thePAT/fieldp_history[1][1] ) );
  DFX2_HV \thePAT/fieldp_history_reg[1][2]  ( .D(\thePAT/fieldp_history[0][2] ), .CP(clk), .Q(\thePAT/fieldp_history[1][2] ) );
  DFX2_HV \thePAT/fieldp_history_reg[1][3]  ( .D(\thePAT/fieldp_history[0][3] ), .CP(clk), .Q(\thePAT/fieldp_history[1][3] ) );
  DFX2_HV \thePAT/fieldp_history_reg[1][4]  ( .D(\thePAT/fieldp_history[0][4] ), .CP(clk), .Q(\thePAT/fieldp_history[1][4] ) );
  DFX2_HV \thePAT/fieldp_history_reg[0][0]  ( .D(buf_fieldp[0]), .CP(clk), .Q(
        \thePAT/fieldp_history[0][0] ) );
  DFX2_HV \thePAT/fieldp_history_reg[0][1]  ( .D(buf_fieldp[1]), .CP(clk), .Q(
        \thePAT/fieldp_history[0][1] ) );
  DFX2_HV \thePAT/fieldp_history_reg[0][2]  ( .D(buf_fieldp[2]), .CP(clk), .Q(
        \thePAT/fieldp_history[0][2] ) );
  DFX2_HV \thePAT/fieldp_history_reg[0][3]  ( .D(buf_fieldp[3]), .CP(clk), .Q(
        \thePAT/fieldp_history[0][3] ) );
  DFX2_HV \thePAT/fieldp_history_reg[0][4]  ( .D(buf_fieldp[4]), .CP(clk), .Q(
        \thePAT/fieldp_history[0][4] ) );
  DFX2_HV \thePAT/fieldp_reg[0]  ( .D(\thePAT/fieldp_next[0] ), .CP(clk), .Q(
        buf_fieldp[0]) );
  DFX2_HV \thePAT/fieldp_reg[1]  ( .D(\thePAT/fieldp_next[1] ), .CP(clk), .Q(
        buf_fieldp[1]) );
  DFX2_HV \thePAT/fieldp_reg[2]  ( .D(\thePAT/fieldp_next[2] ), .CP(clk), .Q(
        buf_fieldp[2]) );
  DFX2_HV \thePAT/fieldp_reg[3]  ( .D(\thePAT/fieldp_next[3] ), .CP(clk), .Q(
        buf_fieldp[3]) );
  DFX2_HV \thePAT/fieldp_reg[4]  ( .D(\thePAT/fieldp_next[4] ), .CP(clk), .Q(
        buf_fieldp[4]) );
  DFX2_HV \thePAT/field_value_reg[0]  ( .D(field_in[0]), .CP(clk), .Q(
        \thePAT/field_value[0] ) );
  DFX2_HV \thePAT/field_value_reg[1]  ( .D(field_in[1]), .CP(clk), .Q(
        \thePAT/field_value[1] ) );
  DFX2_HV \thePAT/field_value_reg[2]  ( .D(field_in[2]), .CP(clk), .Q(
        \thePAT/field_value[2] ) );
  DFX2_HV \thePAT/field_value_reg[3]  ( .D(field_in[3]), .CP(clk), .Q(
        \thePAT/field_value[3] ) );
  DFX2_HV \thePAT/field_value_reg[4]  ( .D(field_in[4]), .CP(clk), .Q(
        \thePAT/field_value[4] ) );
  DFX2_HV \thePAT/field_value_reg[5]  ( .D(field_in[5]), .CP(clk), .Q(
        \thePAT/field_value[5] ) );
  DFX2_HV \thePAT/field_value_reg[6]  ( .D(field_in[6]), .CP(clk), .Q(
        \thePAT/field_value[6] ) );
  DFX2_HV \thePAT/field_value_reg[7]  ( .D(field_in[7]), .CP(clk), .Q(
        \thePAT/field_value[7] ) );
  DFX2_HV \thePAT/field_op_regd_reg  ( .D(\thePAT/n17 ), .CP(clk), .Q(n323), 
        .QN(\thePAT/field_op_regd ) );
  DFX2_HV \thePAT/immediate_regd_2_reg[0]  ( .D(\thePAT/immediate_i8[0] ), 
        .CP(clk), .Q(\thePAT/immediate_regd_2[0] ) );
  DFX2_HV \thePAT/immediate_regd_2_reg[1]  ( .D(\thePAT/immediate_i8[1] ), 
        .CP(clk), .Q(\thePAT/immediate_regd_2[1] ) );
  DFX2_HV \thePAT/immediate_regd_2_reg[2]  ( .D(\thePAT/immediate_i8[2] ), 
        .CP(clk), .Q(\thePAT/immediate_regd_2[2] ) );
  DFX2_HV \thePAT/immediate_regd_2_reg[3]  ( .D(n1523), .CP(clk), .Q(
        \thePAT/immediate_regd_2[3] ) );
  DFX2_HV \thePAT/immediate_regd_2_reg[4]  ( .D(n1524), .CP(clk), .Q(
        \thePAT/immediate_regd_2[4] ) );
  DFX2_HV \thePAT/immediate_regd_2_reg[5]  ( .D(n1525), .CP(clk), .Q(
        \thePAT/immediate_regd_2[5] ) );
  DFX2_HV \thePAT/immediate_regd_2_reg[6]  ( .D(n1526), .CP(clk), .Q(
        \thePAT/immediate_regd_2[6] ) );
  DFX2_HV \thePAT/immediate_regd_2_reg[7]  ( .D(n1527), .CP(clk), .Q(
        \thePAT/immediate_regd_2[7] ) );
  DFX2_HV \thePAT/immediate_regd_reg[0]  ( .D(\thePAT/immediate_i8[0] ), .CP(
        clk), .Q(\thePAT/immediate_regd[0] ) );
  DFX2_HV \thePAT/instruction_1_reg[0]  ( .D(instruction[0]), .CP(clk), .Q(
        \thePAT/immediate_i8[0] ) );
  DFX2_HV \thePAT/instruction_1_reg[1]  ( .D(instruction[1]), .CP(clk), .Q(
        \thePAT/immediate_i8[1] ) );
  DFX2_HV \thePAT/instruction_1_reg[2]  ( .D(instruction[2]), .CP(clk), .Q(
        \thePAT/immediate_i8[2] ) );
  DFX1_HV \thePAT/instruction_1_reg[3]  ( .D(instruction[3]), .CP(clk), .QN(
        \thePAT/n29 ) );
  DFX1_HV \thePAT/instruction_1_reg[4]  ( .D(instruction[4]), .CP(clk), .QN(
        \thePAT/n28 ) );
  DFX1_HV \thePAT/instruction_1_reg[5]  ( .D(instruction[5]), .CP(clk), .QN(
        \thePAT/n27 ) );
  DFX1_HV \thePAT/instruction_1_reg[6]  ( .D(instruction[6]), .CP(clk), .QN(
        \thePAT/n26 ) );
  DFX1_HV \thePAT/instruction_1_reg[7]  ( .D(instruction[7]), .CP(clk), .QN(
        \thePAT/n25 ) );
  DFX2_HV \thePAT/instruction_1_reg[12]  ( .D(instruction[12]), .CP(clk), .Q(
        \thePAT/instruction_1[12] ), .QN(\thePAT/n17 ) );
  DFX2_HV \thePAT/instruction_1_reg[14]  ( .D(instruction[14]), .CP(clk), .Q(
        \thePAT/condition[1] ) );
  DFX2_HV \thePAT/instruction_1_reg[15]  ( .D(instruction[15]), .CP(clk), .Q(
        \thePAT/fieldp_next[0] ) );
  DFX2_HV \thePAT/instruction_1_reg[16]  ( .D(instruction[16]), .CP(clk), .Q(
        \thePAT/fieldp_next[1] ) );
  DFX2_HV \thePAT/instruction_1_reg[17]  ( .D(instruction[17]), .CP(clk), .Q(
        \thePAT/fieldp_next[2] ) );
  DFX2_HV \thePAT/instruction_1_reg[18]  ( .D(instruction[18]), .CP(clk), .Q(
        \thePAT/fieldp_next[3] ) );
  DFX2_HV \thePAT/instruction_1_reg[19]  ( .D(instruction[19]), .CP(clk), .Q(
        \thePAT/fieldp_next[4] ) );
  XNOR2X2_HV \thePAT/add_x_23/U54  ( .A(\thePAT/add_x_23/n52 ), .B(
        \thePAT/add_x_23/n7 ), .Q(\thePAT/thePC/pcAdd[3] ) );
  XNOR2X2_HV \thePAT/add_x_22/U35  ( .A(\thePAT/add_x_22/n31 ), .B(n652), .Q(
        \thePAT/thePC/pcInc[2] ) );
  XNOR2X2_HV \thePAT/add_x_22/U12  ( .A(\thePAT/add_x_22/n13 ), .B(n632), .Q(
        \thePAT/thePC/pcInc[6] ) );
  XNOR2X2_HV \thePAT/add_x_22/U6  ( .A(\thePAT/add_x_22/n9 ), .B(n635), .Q(
        \thePAT/thePC/pcInc[7] ) );
  XNOR2X2_HV \DP_OP_108_135_5866/U32  ( .A(\DP_OP_108_135_5866/n32 ), .B(
        \DP_OP_108_135_5866/n6 ), .Q(n1518) );
  XNOR2X2_HV \DP_OP_108_135_5866/U1  ( .A(\DP_OP_108_135_5866/n11 ), .B(
        \DP_OP_108_135_5866/n2 ), .Q(n1520) );
  XNOR2X2_HV \DP_OP_104_132_4164/U32  ( .A(\DP_OP_104_132_4164/n33 ), .B(
        \DP_OP_104_132_4164/n6 ), .Q(\C1/DATA1_3 ) );
  DFX6_HV \thePAT/acc_reg[1]  ( .D(\thePAT/n792 ), .CP(clk), .Q(acc_out[1]), 
        .QN(\thePAT/n75 ) );
  DFX4_HV \thePAT/acc_reg[5]  ( .D(\thePAT/n784 ), .CP(clk), .Q(n1570) );
  DFX4_HV \thePAT/acc_reg[7]  ( .D(\thePAT/n796 ), .CP(clk), .Q(n1569), .QN(
        n318) );
  DFX4_HV \thePAT/alu_b_regd_2_reg[1]  ( .D(\thePAT/N39 ), .CP(clk), .Q(
        \thePAT/field_alu_b[1] ), .QN(n289) );
  DFX4_HV \thePAT/alu_b_regd_reg[1]  ( .D(\thePAT/N39 ), .CP(clk), .Q(
        \thePAT/acc_alu_b[1] ), .QN(n119) );
  DFX4_HV \thePAT/condition_regd_reg[0]  ( .D(\thePAT/n16 ), .CP(clk), .Q(n653), .QN(\thePAT/condition_regd[0] ) );
  DFX6_HV \thePAT/instruction_3_reg[6]  ( .D(instruction[6]), .CP(clk), .Q(
        \thePAT/opcode_i3[2] ), .QN(n328) );
  DFX4_HV \thePAT/acc_reg[6]  ( .D(\thePAT/n782 ), .CP(clk), .Q(acc_out[6]), 
        .QN(\thePAT/n70 ) );
  DFX4_HV \thePAT/alu_b_regd_2_reg[3]  ( .D(\thePAT/N41 ), .CP(clk), .Q(
        \thePAT/field_alu_b[3] ), .QN(n664) );
  DFX4_HV \thePAT/alu_b_regd_2_reg[4]  ( .D(\thePAT/N42 ), .CP(clk), .Q(
        \thePAT/field_alu_b[4] ), .QN(n322) );
  DFX6_HV \thePAT/instruction_1_reg[11]  ( .D(instruction[11]), .CP(clk), .Q(
        \thePAT/opcode_i8[3] ) );
  DFX6_HV \thePAT/instruction_4_reg[1]  ( .D(instruction[1]), .CP(clk), .Q(
        \thePAT/data_read_adr[1] ), .QN(n298) );
  DFX4_HV \thePAT/alu_b_regd_2_reg[5]  ( .D(\thePAT/N43 ), .CP(clk), .Q(
        \thePAT/field_alu_b[5] ), .QN(n663) );
  DFX6_HV \thePAT/instruction_3_reg[5]  ( .D(instruction[5]), .CP(clk), .Q(
        \thePAT/opcode_i3[1] ), .QN(n348) );
  DFX6_HV \thePAT/instruction_3_reg[1]  ( .D(instruction[1]), .CP(clk), .Q(
        \thePAT/opcode_i0[1] ), .QN(n381) );
  DFX4_HV \thePAT/thePC/pc_reg[3]  ( .D(\thePAT/thePC/N6 ), .CP(clk), .Q(
        \thePAT/thePC/pc[3] ), .QN(n656) );
  DFX4_HV \thePAT/op_sub_subm_regd_reg  ( .D(n1521), .CP(clk), .Q(
        \thePAT/op_sub_subm_regd ), .QN(n346) );
  DFX4_HV \thePAT/source_imm_regd_reg  ( .D(\thePAT/source_imm ), .CP(clk), 
        .Q(n657) );
  DFX4_HV \thePAT/instruction_2_reg[3]  ( .D(instruction[3]), .CP(clk), .Q(
        \thePAT/pc_immediate[3] ) );
  DFX4_HV \thePAT/op_add_addm_regd_2_reg  ( .D(n1522), .CP(clk), .Q(
        \thePAT/op_add_addm_regd_2 ), .QN(n342) );
  DFX4_HV \thePAT/op_add_addm_regd_reg  ( .D(n1522), .CP(clk), .Q(n650), .QN(
        \thePAT/n64 ) );
  DFX4_HV \thePAT/source_in_regd_reg  ( .D(\thePAT/op_in ), .CP(clk), .Q(n649), 
        .QN(\thePAT/n68 ) );
  DFX4_HV \thePAT/instruction_2_reg[5]  ( .D(instruction[5]), .CP(clk), .Q(
        \thePAT/pc_immediate[5] ) );
  DFX4_HV \thePAT/instruction_2_reg[2]  ( .D(instruction[2]), .CP(clk), .Q(
        \thePAT/pc_immediate[2] ) );
  DFX4_HV \thePAT/instruction_2_reg[1]  ( .D(instruction[1]), .CP(clk), .Q(
        \thePAT/pc_immediate[1] ) );
  DFX4_HV \thePAT/op_sub_subm_regd_2_reg  ( .D(n1521), .CP(clk), .Q(
        \thePAT/op_sub_subm_regd_2 ) );
  DFX4_HV \thePAT/alu_b_regd_reg[3]  ( .D(\thePAT/N41 ), .CP(clk), .Q(
        \thePAT/acc_alu_b[3] ), .QN(n645) );
  DFX4_HV \thePAT/instruction_2_reg[4]  ( .D(instruction[4]), .CP(clk), .Q(
        \thePAT/pc_immediate[4] ) );
  DFX4_HV \thePAT/instruction_2_reg[0]  ( .D(instruction[0]), .CP(clk), .Q(
        \thePAT/pc_immediate[0] ) );
  DFX4_HV \thePAT/instruction_2_reg[6]  ( .D(instruction[6]), .CP(clk), .Q(
        \thePAT/pc_immediate[6] ) );
  DFX4_HV \thePAT/thePC/pc_reg[1]  ( .D(\thePAT/thePC/N4 ), .CP(clk), .Q(
        \thePAT/thePC/pc[1] ), .QN(n631) );
  DFX6_HV \thePAT/n_reg  ( .D(\thePAT/n810 ), .CP(clk), .Q(\thePAT/n1 ), .QN(
        n345) );
  DFX4_HV \thePAT/instruction_2_reg[7]  ( .D(instruction[7]), .CP(clk), .Q(
        \thePAT/pc_immediate[7] ), .QN(n636) );
  DFX6_HV \thePAT/alu_b_regd_reg[2]  ( .D(\thePAT/N40 ), .CP(clk), .Q(
        \thePAT/acc_alu_b[2] ), .QN(\thePAT/n46 ) );
  DFX4_HV \thePAT/source_field_regd_reg  ( .D(\thePAT/n17 ), .CP(clk), .Q(n633), .QN(\thePAT/source_field_regd ) );
  DFX4_HV \thePAT/thePC/pc_reg[0]  ( .D(\thePAT/thePC/N3 ), .CP(clk), .Q(
        \thePAT/thePC/pc[0] ), .QN(n627) );
  DFX4_HV \thePAT/op_shl_regd_reg  ( .D(\thePAT/op_shl ), .CP(clk), .Q(
        \thePAT/op_shl_regd ), .QN(n621) );
  DFX6_HV \thePAT/alu_b_regd_2_reg[2]  ( .D(\thePAT/N40 ), .CP(clk), .Q(
        \thePAT/field_alu_b[2] ), .QN(n625) );
  DFX4_HV \thePAT/data_write_adr_reg[4]  ( .D(\thePAT/n800 ), .CP(clk), .Q(
        \thePAT/data_write_adr[4] ) );
  DFX4_HV \thePAT/data_write_adr_reg[5]  ( .D(\thePAT/n799 ), .CP(clk), .Q(
        \thePAT/data_write_adr[5] ) );
  DFX1_HV \thePAT/field_out_reg[7]  ( .D(\thePAT/n764 ), .CP(clk), .Q(
        field_out[7]), .QN(n363) );
  DFX4_HV \thePAT/instruction_4_reg[2]  ( .D(instruction[2]), .CP(clk), .Q(
        \thePAT/data_read_adr[2] ), .QN(n270) );
  DFX4_HV \thePAT/alu_b_regd_reg[5]  ( .D(\thePAT/N43 ), .CP(clk), .Q(
        \thePAT/acc_alu_b[5] ), .QN(n338) );
  DFX1_HV \thePAT/thePC/pc_reg[9]  ( .D(\thePAT/thePC/N23 ), .CP(clk), .Q(
        \thePAT/thePC/pc[9] ), .QN(n337) );
  DFX4_HV \thePAT/alu_b_regd_reg[4]  ( .D(\thePAT/N42 ), .CP(clk), .Q(
        \thePAT/acc_alu_b[4] ), .QN(n319) );
  DFX6_HV \thePAT/op_or_regd_reg  ( .D(\thePAT/op_or ), .CP(clk), .Q(
        \thePAT/op_or_regd ), .QN(n121) );
  DFX4_HV \thePAT/data_write_adr_reg[7]  ( .D(\thePAT/n797 ), .CP(clk), .Q(
        \thePAT/data_write_adr[7] ), .QN(n305) );
  DFX4_HV \thePAT/data_write_reg  ( .D(\thePAT/n808 ), .CP(clk), .Q(
        \thePAT/data_write ) );
  DFX4_HV \thePAT/condition_regd_reg[1]  ( .D(\thePAT/condition[1] ), .CP(clk), 
        .Q(\thePAT/condition_regd[1] ), .QN(n661) );
  DFX4_HV \thePAT/alu_b_regd_reg[0]  ( .D(\thePAT/N38 ), .CP(clk), .Q(
        \thePAT/acc_alu_b[0] ), .QN(n103) );
  DFX4_HV \thePAT/data_write_adr_reg[6]  ( .D(\thePAT/n798 ), .CP(clk), .Q(
        \thePAT/data_write_adr[6] ) );
  DFX1_HV \thePAT/field_out_reg[6]  ( .D(\thePAT/n765 ), .CP(clk), .Q(
        field_out[6]) );
  DFX1_HV \thePAT/thePC/pc_out_reg[7]  ( .D(\thePAT/n8 ), .CP(clk), .Q(pc[7])
         );
  DFX1_HV \thePAT/field_out_reg[2]  ( .D(\thePAT/n769 ), .CP(clk), .Q(
        field_out[2]) );
  DFX1_HV \thePAT/thePC/pc_out_reg[8]  ( .D(\thePAT/n7 ), .CP(clk), .Q(pc[8])
         );
  DFX1_HV \thePAT/field_out_reg[5]  ( .D(\thePAT/n766 ), .CP(clk), .Q(
        field_out[5]) );
  DFX4_HV \thePAT/instruction_1_reg[8]  ( .D(instruction[8]), .CP(clk), .Q(
        \thePAT/opcode_i8[0] ), .QN(n643) );
  DFX3_HV \thePAT/data_write_adr_reg[2]  ( .D(\thePAT/n802 ), .CP(clk), .Q(
        n321), .QN(\thePAT/n78 ) );
  DFX4_HV \thePAT/alu_b_regd_reg[6]  ( .D(\thePAT/N44 ), .CP(clk), .Q(
        \thePAT/acc_alu_b[6] ), .QN(n142) );
  NAND2XL_HV \DP_OP_104_132_4164/U5  ( .A(acc_out[7]), .B(
        \thePAT/acc_alu_b[7] ), .Q(\DP_OP_104_132_4164/n11 ) );
  NAND2XL_HV \DP_OP_104_132_4164/U12  ( .A(n314), .B(\DP_OP_104_132_4164/n18 ), 
        .Q(\DP_OP_104_132_4164/n3 ) );
  NAND2XL_HV \DP_OP_108_135_5866/U5  ( .A(n324), .B(field_in[7]), .Q(
        \DP_OP_108_135_5866/n10 ) );
  NAND2XL_HV \DP_OP_108_135_5866/U2  ( .A(n385), .B(\DP_OP_108_135_5866/n10 ), 
        .Q(\DP_OP_108_135_5866/n2 ) );
  AOI21X3_HV \DP_OP_108_135_5866/U9  ( .A1(\DP_OP_108_135_5866/n22 ), .A2(n371), .B1(\DP_OP_108_135_5866/n15 ), .Q(\DP_OP_108_135_5866/n13 ) );
  NOR2X3_HV \thePAT/add_x_22/U8  ( .A(\thePAT/add_x_22/n14 ), .B(
        \thePAT/add_x_22/n6 ), .Q(\thePAT/add_x_22/n5 ) );
  NAND2X3_HV \thePAT/add_x_23/U16  ( .A(\thePAT/add_x_23/n33 ), .B(
        \thePAT/add_x_23/n21 ), .Q(\thePAT/add_x_23/n19 ) );
  CLKINVX2_HV \DP_OP_108_135_5866/U18  ( .A(\DP_OP_108_135_5866/n21 ), .Q(
        \DP_OP_108_135_5866/n19 ) );
  CLKINVX2_HV \DP_OP_108_135_5866/U19  ( .A(\DP_OP_108_135_5866/n22 ), .Q(
        \DP_OP_108_135_5866/n20 ) );
  NAND2X3_HV \DP_OP_104_132_4164/U28  ( .A(n523), .B(\DP_OP_104_132_4164/n28 ), 
        .Q(\DP_OP_104_132_4164/n5 ) );
  NAND2X3_HV \DP_OP_104_132_4164/U42  ( .A(\DP_OP_104_132_4164/n47 ), .B(
        \DP_OP_104_132_4164/n35 ), .Q(\DP_OP_104_132_4164/n7 ) );
  NAND2X3_HV \DP_OP_104_132_4164/U49  ( .A(n131), .B(\DP_OP_104_132_4164/n39 ), 
        .Q(\DP_OP_104_132_4164/n8 ) );
  NAND2X3_HV \thePAT/add_x_23/U50  ( .A(\thePAT/add_x_23/n66 ), .B(
        \thePAT/add_x_23/n45 ), .Q(\thePAT/add_x_23/n6 ) );
  NAND2X3_HV \thePAT/add_x_23/U30  ( .A(\thePAT/add_x_23/n64 ), .B(
        \thePAT/add_x_23/n31 ), .Q(\thePAT/add_x_23/n4 ) );
  DFX4_HV \thePAT/thePC/pc_reg[7]  ( .D(\thePAT/thePC/N21 ), .CP(clk), .Q(
        \thePAT/thePC/pc[7] ), .QN(n635) );
  DFX4_HV \thePAT/op_and_regd_reg  ( .D(\thePAT/op_and ), .CP(clk), .Q(
        \thePAT/op_and_regd ), .QN(n122) );
  DFX6_HV \thePAT/acc_reg[2]  ( .D(\thePAT/n790 ), .CP(clk), .Q(n1572), .QN(
        \thePAT/n74 ) );
  DFX4_HV \thePAT/alu_b_regd_2_reg[7]  ( .D(\thePAT/N45 ), .CP(clk), .Q(
        \thePAT/field_alu_b[7] ), .QN(n324) );
  DFX4_HV \thePAT/alu_b_regd_2_reg[0]  ( .D(\thePAT/N38 ), .CP(clk), .Q(
        \thePAT/field_alu_b[0] ), .QN(n641) );
  DFX6_HV \thePAT/z_reg  ( .D(\thePAT/n781 ), .CP(clk), .Q(\thePAT/z1 ) );
  DFX4_HV \thePAT/op_not_regd_reg  ( .D(\thePAT/op_not ), .CP(clk), .Q(
        \thePAT/op_not_regd ) );
  DFX6_HV \thePAT/instruction_3_reg[3]  ( .D(instruction[3]), .CP(clk), .Q(
        \thePAT/opcode_i0[3] ), .QN(n327) );
  DFX4_HV \thePAT/acc_reg[4]  ( .D(\thePAT/n786 ), .CP(clk), .Q(acc_out[4]), 
        .QN(\acc_out[4]_BAR ) );
  DFX6_HV \thePAT/instruction_3_reg[4]  ( .D(instruction[4]), .CP(clk), .Q(
        \thePAT/opcode_i3[0] ), .QN(n296) );
  DFX4_HV \thePAT/op_shr_regd_reg  ( .D(\thePAT/op_shr ), .CP(clk), .Q(n283), 
        .QN(\thePAT/n57 ) );
  DFX4_HV \thePAT/instruction_1_reg[9]  ( .D(instruction[9]), .CP(clk), .Q(
        \thePAT/opcode_i8[1] ), .QN(n644) );
  DFX6_HV \thePAT/instruction_3_reg[7]  ( .D(instruction[7]), .CP(clk), .Q(
        \thePAT/opcode_i3[3] ), .QN(n316) );
  DFX4_HV \thePAT/alu_b_regd_reg[7]  ( .D(\thePAT/N45 ), .CP(clk), .Q(
        \thePAT/acc_alu_b[7] ), .QN(n312) );
  DFX3_HV \thePAT/field_out_reg[0]  ( .D(\thePAT/n771 ), .CP(clk), .Q(
        field_out[0]) );
  DFX6_HV \thePAT/instruction_1_reg[10]  ( .D(instruction[10]), .CP(clk), .Q(
        \thePAT/opcode_i8[2] ), .QN(n325) );
  NAND2X3_HV \DP_OP_108_135_5866/U12  ( .A(n371), .B(\DP_OP_108_135_5866/n17 ), 
        .Q(\DP_OP_108_135_5866/n3 ) );
  DFX1_HV \thePAT/instruction_1_reg[13]  ( .D(instruction[13]), .CP(clk), .QN(
        \thePAT/n16 ) );
  DFX1_HV \thePAT/immediate_regd_reg[2]  ( .D(\thePAT/immediate_i8[2] ), .CP(
        clk), .QN(n360) );
  DFX1_HV \thePAT/immediate_regd_reg[1]  ( .D(\thePAT/immediate_i8[1] ), .CP(
        clk), .QN(n359) );
  DFX1_HV \thePAT/dest_dmem_regd_reg  ( .D(\thePAT/dest_dmem ), .CP(clk), .Q(
        n172) );
  DFX1_HV \thePAT/op_out_regd_reg  ( .D(\thePAT/op_out ), .CP(clk), .QN(n350)
         );
  DFX1_HV \thePAT/op_setb_regd_reg  ( .D(n83), .CP(clk), .QN(n368) );
  DFX3_HV \thePAT/instruction_4_reg[3]  ( .D(instruction[3]), .CP(clk), .Q(
        \thePAT/data_read_adr[3] ), .QN(n295) );
  DFX3_HV \thePAT/data_write_adr_reg[3]  ( .D(\thePAT/n801 ), .CP(clk), .Q(
        n306), .QN(\thePAT/n77 ) );
  DFX3_HV \thePAT/data_write_adr_reg[1]  ( .D(\thePAT/n803 ), .CP(clk), .Q(
        n336), .QN(\thePAT/n79 ) );
  DFX1_HV \thePAT/data_out_reg[7]  ( .D(\thePAT/n772 ), .CP(clk), .Q(
        \thePAT/data_out[7] ) );
  DFX1_HV \thePAT/data_out_reg[6]  ( .D(\thePAT/n773 ), .CP(clk), .Q(
        \thePAT/data_out[6] ) );
  DFX1_HV \thePAT/data_out_reg[5]  ( .D(\thePAT/n774 ), .CP(clk), .Q(
        \thePAT/data_out[5] ) );
  DFX1_HV \thePAT/data_out_reg[4]  ( .D(\thePAT/n775 ), .CP(clk), .Q(
        \thePAT/data_out[4] ) );
  DFX1_HV \thePAT/data_out_reg[3]  ( .D(\thePAT/n776 ), .CP(clk), .Q(
        \thePAT/data_out[3] ) );
  DFX1_HV \thePAT/data_out_reg[2]  ( .D(\thePAT/n777 ), .CP(clk), .Q(
        \thePAT/data_out[2] ) );
  DFX1_HV \thePAT/data_out_reg[1]  ( .D(\thePAT/n778 ), .CP(clk), .Q(
        \thePAT/data_out[1] ) );
  DFX1_HV \thePAT/data_out_reg[0]  ( .D(\thePAT/n779 ), .CP(clk), .Q(
        \thePAT/data_out[0] ) );
  DFX1_HV \iBuffer/instruction_out_reg[11]  ( .D(\iBuffer/N42 ), .CP(clk), .Q(
        instruction[11]) );
  DFX1_HV \iBuffer/instruction_out_reg[9]  ( .D(\iBuffer/N40 ), .CP(clk), .Q(
        instruction[9]) );
  DFX1_HV \iBuffer/instruction_out_reg[8]  ( .D(\iBuffer/N39 ), .CP(clk), .Q(
        instruction[8]) );
  DFX1_HV \iBuffer/instruction_out_reg[7]  ( .D(\iBuffer/N38 ), .CP(clk), .Q(
        instruction[7]) );
  DFX1_HV \iBuffer/instruction_out_reg[6]  ( .D(\iBuffer/N37 ), .CP(clk), .Q(
        instruction[6]) );
  DFX1_HV \iBuffer/instruction_out_reg[5]  ( .D(\iBuffer/N36 ), .CP(clk), .Q(
        instruction[5]) );
  DFX1_HV \iBuffer/instruction_out_reg[2]  ( .D(\iBuffer/N33 ), .CP(clk), .Q(
        instruction[2]) );
  DFX1_HV \iBuffer/instruction_out_reg[0]  ( .D(\iBuffer/N31 ), .CP(clk), .Q(
        instruction[0]) );
  DFX1_HV \thePAT/bufp_reg[0]  ( .D(\thePAT/n807 ), .CP(clk), .Q(buf_fieldp[5]) );
  DFX1_HV \thePAT/thePC/pc_out_reg[9]  ( .D(\thePAT/n6 ), .CP(clk), .Q(pc[9])
         );
  DFX1_HV \thePAT/thePC/pc_out_reg[5]  ( .D(\thePAT/n10 ), .CP(clk), .Q(pc[5])
         );
  DFX1_HV \thePAT/field_out_reg[1]  ( .D(\thePAT/n770 ), .CP(clk), .Q(
        field_out[1]) );
  DFX4_HV \thePAT/op_mov_regd_reg  ( .D(\thePAT/op_mov ), .CP(clk), .Q(
        \thePAT/op_mov_regd ), .QN(n646) );
  DFX1_HV \thePAT/thePC/pc_out_reg[4]  ( .D(\thePAT/n11 ), .CP(clk), .Q(pc[4])
         );
  DFX4_HV \thePAT/alu_b_regd_2_reg[6]  ( .D(\thePAT/N44 ), .CP(clk), .Q(
        \thePAT/field_alu_b[6] ), .QN(n659) );
  DFX4_HV \thePAT/op_shlo_regd_reg  ( .D(\thePAT/op_shlo ), .CP(clk), .Q(
        \thePAT/op_shlo_regd ), .QN(n150) );
  DFX4_HV \thePAT/dest_acc_regd_reg  ( .D(\thePAT/dest_acc ), .CP(clk), .Q(
        \thePAT/dest_acc_regd ), .QN(n141) );
  DFX4_HV \thePAT/thePC/pc_out_reg[0]  ( .D(\thePAT/n15 ), .CP(clk), .QN(n138)
         );
  DFX6_HV \thePAT/thePC/pc_reg[6]  ( .D(\thePAT/thePC/N9 ), .CP(clk), .Q(
        \thePAT/thePC/pc[6] ), .QN(n632) );
  DFX6_HV \thePAT/acc_reg[0]  ( .D(\thePAT/n794 ), .CP(clk), .Q(acc_out[0]), 
        .QN(\thePAT/n76 ) );
  DFX3_HV \iBuffer/instruction_out_reg[3]  ( .D(\iBuffer/N34 ), .CP(clk), .Q(
        instruction[3]) );
  DFX6_HV \thePAT/instruction_4_reg[0]  ( .D(instruction[0]), .CP(clk), .Q(
        \thePAT/data_read_adr[0] ), .QN(n658) );
  DFX1_HV \thePAT/field_out_reg[4]  ( .D(\thePAT/n767 ), .CP(clk), .Q(
        field_out[4]) );
  DFX6_HV \thePAT/acc_reg[3]  ( .D(\thePAT/n788 ), .CP(clk), .Q(n1571), .QN(
        \thePAT/n73 ) );
  DFX3_HV \iBuffer/instruction_out_reg[1]  ( .D(\iBuffer/N32 ), .CP(clk), .Q(
        instruction[1]) );
  DFX1_HV \thePAT/thePC/pc_out_reg[6]  ( .D(\thePAT/n9 ), .CP(clk), .Q(pc[6])
         );
  DFX6_HV \thePAT/thePC/pc_reg[2]  ( .D(\thePAT/thePC/N5 ), .CP(clk), .Q(
        \thePAT/thePC/pc[2] ), .QN(n652) );
  DFX1_HV \thePAT/field_out_reg[3]  ( .D(\thePAT/n768 ), .CP(clk), .Q(
        field_out[3]) );
  DFX1_HV \thePAT/outputs_reg[7]  ( .D(\thePAT/n795 ), .CP(clk), .Q(outputs[7]) );
  DFX2_HV \thePAT/dest_field_regd_reg  ( .D(\thePAT/dest_field ), .CP(clk), 
        .Q(\thePAT/dest_field_regd ), .QN(n326) );
  DFX4_HV \thePAT/instruction_3_reg[0]  ( .D(instruction[0]), .CP(clk), .Q(
        n315), .QN(\thePAT/n35 ) );
  DFX4_HV \thePAT/instruction_3_reg[2]  ( .D(instruction[2]), .CP(clk), .Q(
        \thePAT/opcode_i0[2] ), .QN(n297) );
  DFX4_HV \thePAT/thePC/pc_reg[4]  ( .D(\thePAT/thePC/N7 ), .CP(clk), .Q(
        \thePAT/thePC/pc[4] ), .QN(n630) );
  DFX6_HV \thePAT/thePC/pc_reg[5]  ( .D(\thePAT/thePC/N8 ), .CP(clk), .Q(
        \thePAT/thePC/pc[5] ), .QN(n639) );
  DFX6_HV \thePAT/thePC/pc_reg[8]  ( .D(\thePAT/thePC/N22 ), .CP(clk), .Q(
        \thePAT/thePC/pc[8] ), .QN(n317) );
  DFX6_HV \thePAT/data_write_adr_reg[0]  ( .D(\thePAT/n804 ), .CP(clk), .Q(
        n354), .QN(\thePAT/n80 ) );
  AOI22X3_HV U1 ( .A1(n2), .A2(n1), .B1(n678), .B2(\thePAT/field_alu_b[7] ), 
        .Q(n1322) );
  CLKINVX4_HV U2 ( .A(n1321), .Q(n1) );
  CLKINVX4_HV U3 ( .A(n677), .Q(n2) );
  NAND4X6_HV U4 ( .A(n28), .B(n17), .C(n890), .D(n25), .Q(n468) );
  NAND3X6_HV U5 ( .A(n496), .B(n1344), .C(n409), .Q(n488) );
  NAND3X6_HV U6 ( .A(n258), .B(n1344), .C(n409), .Q(n257) );
  AND3X3_HV U7 ( .A(n1376), .B(n1362), .C(n1363), .Q(n490) );
  CLKINVX8_HV U8 ( .A(n3), .Q(n147) );
  NAND2X8_HV U9 ( .A(n219), .B(n399), .Q(n3) );
  NAND2X3_HV U10 ( .A(n678), .B(n114), .Q(n1023) );
  AND3X4_HV U11 ( .A(n1023), .B(n1132), .C(n1026), .Q(n1024) );
  NAND3X12_HV U12 ( .A(n4), .B(n660), .C(n916), .Q(n95) );
  CLKINVX12_HV U13 ( .A(n1011), .Q(n4) );
  NAND2X12_HV U14 ( .A(n4), .B(n232), .Q(n975) );
  AOI22X8_HV U15 ( .A1(\acc_out[0]_BAR ), .A2(n4), .B1(\acc_out[1]_BAR ), .B2(
        n159), .Q(n959) );
  CLKINVX4_HV U16 ( .A(n472), .Q(n884) );
  OAI21X8_HV U17 ( .A1(n881), .A2(n8), .B1(n5), .Q(n472) );
  AOI21X8_HV U18 ( .A1(n879), .A2(n7), .B1(n6), .Q(n5) );
  CLKINVX4_HV U19 ( .A(n880), .Q(n6) );
  CLKINVX4_HV U20 ( .A(n878), .Q(n7) );
  CLKINVX4_HV U21 ( .A(n879), .Q(n8) );
  NAND2X8_HV U22 ( .A(n665), .B(\thePAT/acc_alu_b[6] ), .Q(n879) );
  NAND2X8_HV U23 ( .A(n948), .B(n311), .Q(n881) );
  CLKINVX4_HV U24 ( .A(n9), .Q(n311) );
  NAND2X8_HV U25 ( .A(n14), .B(n319), .Q(n9) );
  NAND2X8_HV U26 ( .A(n1239), .B(\thePAT/acc_alu_b[5] ), .Q(n948) );
  NAND2X12_HV U27 ( .A(n920), .B(n660), .Q(n1002) );
  NOR2X12_HV U28 ( .A(n11), .B(n10), .Q(n920) );
  CLKINVX4_HV U29 ( .A(n682), .Q(n10) );
  CLKINVX3_HV U30 ( .A(n231), .Q(n11) );
  CLKINVX24_HV U31 ( .A(n231), .Q(n681) );
  CLKINVX32_HV U32 ( .A(n682), .Q(n916) );
  NAND2X8_HV U33 ( .A(n13), .B(n12), .Q(n1045) );
  CLKINVX4_HV U34 ( .A(\thePAT/n74 ), .Q(n12) );
  CLKINVX4_HV U35 ( .A(n1002), .Q(n13) );
  NAND2X4_HV U36 ( .A(\thePAT/n68 ), .B(\thePAT/op_or_regd ), .Q(n204) );
  BUFX24_HV U37 ( .A(acc_out[4]), .Q(n14) );
  CLKINVX12_HV U38 ( .A(n686), .Q(n1239) );
  NAND2X4_HV U39 ( .A(n881), .B(n878), .Q(n429) );
  CLKBUFX8_HV U40 ( .A(n104), .Q(n15) );
  NAND2X12_HV U41 ( .A(n1099), .B(n16), .Q(n890) );
  AND3X6_HV U42 ( .A(n634), .B(\thePAT/field_value[7] ), .C(
        \thePAT/dest_acc_regd ), .Q(n16) );
  OAI21X6_HV U43 ( .A1(n22), .A2(n18), .B1(n528), .Q(n17) );
  NOR2X12_HV U44 ( .A(n1006), .B(n975), .Q(n18) );
  NAND2X8_HV U45 ( .A(n20), .B(n19), .Q(n1006) );
  NAND2X4_HV U46 ( .A(\thePAT/n76 ), .B(n15), .Q(n19) );
  NAND2X8_HV U47 ( .A(\acc_out[1]_BAR ), .B(n21), .Q(n20) );
  CLKINVX4_HV U48 ( .A(n15), .Q(n21) );
  OAI22X6_HV U49 ( .A1(n1035), .A2(n127), .B1(\thePAT/n74 ), .B2(n52), .Q(n22)
         );
  NAND2X12_HV U50 ( .A(n24), .B(n23), .Q(n1035) );
  INVX8_HV U51 ( .A(n642), .Q(n23) );
  INVX8_HV U52 ( .A(n49), .Q(n24) );
  NOR2X8_HV U53 ( .A(n1329), .B(n26), .Q(n25) );
  CLKINVX8_HV U54 ( .A(n27), .Q(n26) );
  NAND2X4_HV U55 ( .A(n678), .B(\thePAT/acc_alu_b[7] ), .Q(n27) );
  NAND2X6_HV U56 ( .A(n222), .B(n29), .Q(n28) );
  AND3X6_HV U57 ( .A(n958), .B(n1040), .C(n695), .Q(n29) );
  AND3X6_HV U58 ( .A(n888), .B(n31), .C(n30), .Q(n222) );
  NAND2X12_HV U59 ( .A(n341), .B(n127), .Q(n30) );
  NAND2X6_HV U60 ( .A(n887), .B(n1012), .Q(n31) );
  NAND2X8_HV U61 ( .A(n33), .B(n32), .Q(\DP_OP_104_132_4164/n12 ) );
  AOI21X6_HV U62 ( .A1(\DP_OP_104_132_4164/n23 ), .A2(n314), .B1(
        \DP_OP_104_132_4164/n16 ), .Q(n32) );
  OAI21X4_HV U63 ( .A1(\DP_OP_104_132_4164/n24 ), .A2(\DP_OP_104_132_4164/n28 ), .B1(\DP_OP_104_132_4164/n25 ), .Q(\DP_OP_104_132_4164/n23 ) );
  NAND2X12_HV U64 ( .A(n686), .B(\thePAT/acc_alu_b[5] ), .Q(
        \DP_OP_104_132_4164/n25 ) );
  NAND2X12_HV U65 ( .A(acc_out[4]), .B(\thePAT/acc_alu_b[4] ), .Q(
        \DP_OP_104_132_4164/n28 ) );
  NAND3X12_HV U66 ( .A(n525), .B(\DP_OP_104_132_4164/n22 ), .C(n314), .Q(n33)
         );
  NAND2X12_HV U67 ( .A(n35), .B(n34), .Q(n314) );
  CLKINVX8_HV U68 ( .A(acc_out[6]), .Q(n34) );
  CLKINVX8_HV U69 ( .A(\thePAT/acc_alu_b[6] ), .Q(n35) );
  NOR2X8_HV U70 ( .A(\DP_OP_104_132_4164/n24 ), .B(n156), .Q(
        \DP_OP_104_132_4164/n22 ) );
  NAND2X12_HV U71 ( .A(n37), .B(n36), .Q(n525) );
  OA21X8_HV U72 ( .A1(\DP_OP_104_132_4164/n35 ), .A2(\DP_OP_104_132_4164/n31 ), 
        .B1(\DP_OP_104_132_4164/n32 ), .Q(n36) );
  NAND2X12_HV U73 ( .A(\DP_OP_104_132_4164/n37 ), .B(\DP_OP_104_132_4164/n29 ), 
        .Q(n37) );
  CLKBUFX8_HV U74 ( .A(n453), .Q(n38) );
  INVX6_HV U75 ( .A(n407), .Q(n453) );
  OAI211X8_HV U76 ( .A1(n44), .A2(n40), .B1(n295), .C1(n407), .Q(n759) );
  NAND3X12_HV U77 ( .A(n701), .B(n313), .C(n39), .Q(n407) );
  NAND2X12_HV U78 ( .A(n423), .B(n446), .Q(n39) );
  OA21X8_HV U79 ( .A1(n821), .A2(n820), .B1(n806), .Q(n313) );
  NAND3X12_HV U80 ( .A(n699), .B(n154), .C(n700), .Q(n701) );
  NAND3X8_HV U81 ( .A(n43), .B(n42), .C(n41), .Q(n40) );
  NAND2X8_HV U82 ( .A(n671), .B(\thePAT/dmem/dmem[7][3] ), .Q(n41) );
  AOI22X2_HV U83 ( .A1(n787), .A2(\thePAT/dmem/dmem[1][3] ), .B1(n668), .B2(
        \thePAT/dmem/dmem[2][3] ), .Q(n42) );
  NAND2X8_HV U84 ( .A(n670), .B(\thePAT/dmem/dmem[0][3] ), .Q(n43) );
  NAND4X6_HV U85 ( .A(n48), .B(n47), .C(n46), .D(n45), .Q(n44) );
  NAND2X8_HV U86 ( .A(n672), .B(\thePAT/dmem/dmem[6][3] ), .Q(n45) );
  NAND2X8_HV U87 ( .A(n669), .B(\thePAT/dmem/dmem[3][3] ), .Q(n46) );
  NAND2X8_HV U88 ( .A(n789), .B(\thePAT/dmem/dmem[4][3] ), .Q(n47) );
  NAND2X8_HV U89 ( .A(n788), .B(\thePAT/dmem/dmem[5][3] ), .Q(n48) );
  CLKINVX8_HV U90 ( .A(n649), .Q(n406) );
  OR2X6_HV U91 ( .A(n679), .B(n519), .Q(n379) );
  NAND2X8_HV U92 ( .A(n214), .B(n213), .Q(n212) );
  NAND2X6_HV U93 ( .A(n676), .B(acc_out[3]), .Q(n1046) );
  NAND2X3_HV U94 ( .A(n676), .B(acc_out[2]), .Q(n54) );
  CLKINVX6_HV U95 ( .A(n1040), .Q(n49) );
  INVX8_HV U96 ( .A(\thePAT/thePC/N7 ), .Q(n1444) );
  NAND4X6_HV U97 ( .A(n750), .B(n749), .C(n747), .D(n748), .Q(n419) );
  NAND4X6_HV U98 ( .A(n779), .B(n778), .C(n776), .D(n777), .Q(n426) );
  AND2X6_HV U99 ( .A(n349), .B(\thePAT/add_x_23/n60 ), .Q(n391) );
  CLKINVX12_HV U100 ( .A(n123), .Q(n135) );
  NAND2X3_HV U101 ( .A(n243), .B(n1436), .Q(\thePAT/n15 ) );
  CLKINVX12_HV U102 ( .A(\thePAT/acc_alu_b[2] ), .Q(n660) );
  NOR2X12_HV U103 ( .A(n863), .B(n171), .Q(n673) );
  NAND3X6_HV U104 ( .A(n1285), .B(n1284), .C(n1283), .Q(\thePAT/n772 ) );
  NAND2X6_HV U105 ( .A(n1339), .B(\thePAT/field_value[7] ), .Q(n1284) );
  CLKINVX4_HV U106 ( .A(n1036), .Q(n1037) );
  NAND2X12_HV U107 ( .A(n970), .B(n695), .Q(n1036) );
  CLKINVX2_HV U108 ( .A(n993), .Q(n50) );
  NAND2X8_HV U109 ( .A(n681), .B(n682), .Q(n993) );
  NAND2X6_HV U110 ( .A(n906), .B(n120), .Q(n195) );
  OAI211X6_HV U111 ( .A1(n1370), .A2(n1367), .B1(n1118), .C1(n1117), .Q(n1326)
         );
  NAND3X12_HV U112 ( .A(n935), .B(n1016), .C(n651), .Q(n566) );
  NOR2X12_HV U113 ( .A(n1036), .B(n93), .Q(n210) );
  NAND2X6_HV U114 ( .A(\thePAT/add_x_23/n68 ), .B(n626), .Q(n72) );
  CLKINVX4_HV U115 ( .A(n1260), .Q(n478) );
  NOR2X6_HV U116 ( .A(field_in[1]), .B(n165), .Q(n59) );
  CLKINVX4_HV U117 ( .A(n281), .Q(n51) );
  OA21X6_HV U118 ( .A1(\DP_OP_104_132_4164/n38 ), .A2(\DP_OP_104_132_4164/n41 ), .B1(\DP_OP_104_132_4164/n39 ), .Q(n281) );
  NAND2X6_HV U119 ( .A(\thePAT/thePC/pcAdd[3] ), .B(n135), .Q(n1429) );
  AND2X6_HV U120 ( .A(n1433), .B(n1446), .Q(n288) );
  NAND4X6_HV U121 ( .A(n794), .B(n796), .C(n795), .D(n797), .Q(n450) );
  NAND3X8_HV U122 ( .A(n451), .B(n295), .C(n450), .Q(n449) );
  NAND2X6_HV U123 ( .A(n1091), .B(n1232), .Q(n1092) );
  NAND2X6_HV U124 ( .A(n1306), .B(n245), .Q(n1108) );
  NAND3X6_HV U125 ( .A(n1282), .B(n1281), .C(n1280), .Q(\thePAT/n771 ) );
  NAND3X6_HV U126 ( .A(n1452), .B(\thePAT/n35 ), .C(n825), .Q(n826) );
  OAI21X6_HV U127 ( .A1(n157), .A2(n1113), .B1(n478), .Q(n477) );
  CLKINVX10_HV U128 ( .A(n680), .Q(n457) );
  NOR2X12_HV U129 ( .A(n459), .B(n350), .Q(n680) );
  AND2X6_HV U130 ( .A(n1011), .B(n916), .Q(n341) );
  NAND4X6_HV U131 ( .A(n58), .B(n55), .C(n549), .D(n54), .Q(n53) );
  OA21X6_HV U132 ( .A1(n967), .A2(n102), .B1(n968), .Q(n58) );
  NAND2X6_HV U133 ( .A(n135), .B(\thePAT/thePC/pcAdd[4] ), .Q(n1430) );
  CLKINVX8_HV U134 ( .A(\thePAT/thePC/N22 ), .Q(n1448) );
  NAND2X12_HV U135 ( .A(n1435), .B(n1434), .Q(\thePAT/thePC/N22 ) );
  NAND2X6_HV U136 ( .A(n1055), .B(\thePAT/field_value[5] ), .Q(n925) );
  NAND2X6_HV U137 ( .A(n1055), .B(\thePAT/field_value[6] ), .Q(n857) );
  NAND2X6_HV U138 ( .A(n1055), .B(\thePAT/field_value[3] ), .Q(n1056) );
  NAND2X6_HV U139 ( .A(n1055), .B(\thePAT/field_value[0] ), .Q(n899) );
  NOR2X12_HV U140 ( .A(n84), .B(n1019), .Q(n1055) );
  AND3X8_HV U141 ( .A(n929), .B(n928), .C(n927), .Q(n303) );
  CLKINVX10_HV U142 ( .A(\thePAT/op_and_regd ), .Q(n992) );
  NAND2X3_HV U143 ( .A(n916), .B(\acc_out[1]_BAR ), .Q(n918) );
  NOR2X12_HV U144 ( .A(n940), .B(n159), .Q(n998) );
  NAND2X3_HV U145 ( .A(\acc_out[0]_BAR ), .B(n159), .Q(n917) );
  NAND2X12_HV U146 ( .A(n1392), .B(n159), .Q(n1012) );
  NAND2X12_HV U147 ( .A(n660), .B(n80), .Q(n1073) );
  NAND4X6_HV U148 ( .A(n923), .B(n922), .C(n1005), .D(n921), .Q(n924) );
  AND2X6_HV U149 ( .A(n935), .B(\thePAT/op_shlo_regd ), .Q(n1013) );
  CLKINVX8_HV U150 ( .A(\thePAT/op_shl_regd ), .Q(n935) );
  NOR2X4_HV U151 ( .A(n397), .B(n1027), .Q(n1047) );
  AND3X6_HV U152 ( .A(n965), .B(n187), .C(n188), .Q(n186) );
  CLKINVX8_HV U153 ( .A(n1002), .Q(n531) );
  NOR2X6_HV U154 ( .A(n1002), .B(\acc_out[1]_BAR ), .Q(n955) );
  OA21X3_HV U155 ( .A1(n1002), .A2(n1239), .B1(n968), .Q(n143) );
  NAND2X12_HV U156 ( .A(n531), .B(acc_out[3]), .Q(n549) );
  NAND2X6_HV U157 ( .A(n531), .B(n249), .Q(n1034) );
  NAND3X8_HV U158 ( .A(n60), .B(n701), .C(n313), .Q(n444) );
  AND2X4_HV U159 ( .A(n407), .B(n295), .Q(n367) );
  AND2X8_HV U160 ( .A(n549), .B(n355), .Q(n155) );
  NAND3X8_HV U161 ( .A(n340), .B(n988), .C(n987), .Q(n502) );
  NAND2X8_HV U162 ( .A(n1147), .B(n1382), .Q(n174) );
  OAI21X8_HV U163 ( .A1(n129), .A2(n277), .B1(n197), .Q(
        \DP_OP_108_135_5866/n32 ) );
  OAI21X6_HV U164 ( .A1(n400), .A2(n285), .B1(n398), .Q(n1139) );
  AND3X6_HV U165 ( .A(n533), .B(n1214), .C(n1213), .Q(n532) );
  NAND3X6_HV U166 ( .A(n648), .B(\thePAT/n68 ), .C(\thePAT/op_and_regd ), .Q(
        n1354) );
  CLKINVX12_HV U167 ( .A(n657), .Q(n648) );
  NAND2X3_HV U168 ( .A(n52), .B(n975), .Q(n527) );
  AND2X6_HV U169 ( .A(n1163), .B(n411), .Q(n1166) );
  AND2X6_HV U170 ( .A(\thePAT/add_x_22/n31 ), .B(n79), .Q(n282) );
  NAND2X12_HV U171 ( .A(n1011), .B(n916), .Q(n642) );
  AOI21X8_HV U172 ( .A1(n1296), .A2(n1257), .B1(n1256), .Q(n1282) );
  CLKBUFX16_HV U173 ( .A(n683), .Q(n248) );
  BUFX32_HV U174 ( .A(\thePAT/field_alu_b[2] ), .Q(n683) );
  CLKINVX8_HV U175 ( .A(\thePAT/field_alu_b[2] ), .Q(n255) );
  NAND3X6_HV U176 ( .A(n1298), .B(n1294), .C(n1299), .Q(n1297) );
  NAND2X12_HV U177 ( .A(\thePAT/opcode_i8[2] ), .B(\thePAT/opcode_i8[0] ), .Q(
        n802) );
  NAND2X8_HV U178 ( .A(n1452), .B(n1451), .Q(n1485) );
  NAND2X12_HV U179 ( .A(n1430), .B(n1431), .Q(\thePAT/thePC/N7 ) );
  AND3X6_HV U180 ( .A(n619), .B(n695), .C(n622), .Q(n309) );
  NAND2X6_HV U181 ( .A(n619), .B(n1225), .Q(n927) );
  NOR2X4_HV U182 ( .A(n1201), .B(n1308), .Q(n1272) );
  NAND3X8_HV U183 ( .A(n1083), .B(n1082), .C(n1081), .Q(\thePAT/n788 ) );
  NAND4X8_HV U184 ( .A(n155), .B(n973), .C(n972), .D(n548), .Q(n214) );
  OR2X8_HV U185 ( .A(n285), .B(n343), .Q(n1214) );
  NAND2X3_HV U186 ( .A(n285), .B(field_out[3]), .Q(n1100) );
  AOI22X6_HV U187 ( .A1(n494), .A2(n149), .B1(n490), .B2(n1361), .Q(n489) );
  NAND2X6_HV U188 ( .A(n366), .B(n485), .Q(n1019) );
  NOR2X8_HV U189 ( .A(n1059), .B(n1058), .Q(n1062) );
  NOR2X6_HV U190 ( .A(n902), .B(n901), .Q(n915) );
  NAND4X8_HV U191 ( .A(n900), .B(n170), .C(n169), .D(n898), .Q(n901) );
  AOI22X3_HV U192 ( .A1(n147), .A2(n108), .B1(n286), .B2(field_out[6]), .Q(
        n384) );
  NAND2X6_HV U193 ( .A(n147), .B(acc_out[5]), .Q(n569) );
  NAND2X8_HV U194 ( .A(n1148), .B(n250), .Q(n1309) );
  OAI21X8_HV U195 ( .A1(n1335), .A2(n1334), .B1(n1376), .Q(n1336) );
  NAND3X4_HV U196 ( .A(\thePAT/op_or_regd ), .B(n648), .C(n406), .Q(n1352) );
  NAND2X12_HV U197 ( .A(n872), .B(n871), .Q(n873) );
  NOR2X8_HV U198 ( .A(\thePAT/add_x_23/n44 ), .B(\thePAT/add_x_23/n39 ), .Q(
        \thePAT/add_x_23/n33 ) );
  NAND2X8_HV U199 ( .A(n994), .B(n993), .Q(n997) );
  NAND3X6_HV U200 ( .A(n1333), .B(n1332), .C(n1331), .Q(n1334) );
  NAND2X6_HV U201 ( .A(n602), .B(n590), .Q(\thePAT/n792 ) );
  NAND3X8_HV U202 ( .A(n373), .B(n506), .C(n309), .Q(n505) );
  NOR2X8_HV U203 ( .A(n1288), .B(n1380), .Q(n1289) );
  AOI21X8_HV U204 ( .A1(\thePAT/add_x_23/n46 ), .A2(\thePAT/add_x_23/n33 ), 
        .B1(n92), .Q(\thePAT/add_x_23/n32 ) );
  NAND3X4_HV U205 ( .A(n1376), .B(\thePAT/field_alu_b[4] ), .C(n167), .Q(n1165) );
  CLKINVX6_HV U206 ( .A(n103), .Q(n104) );
  NAND2X8_HV U207 ( .A(n930), .B(n1040), .Q(n52) );
  CLKINVX4_HV U208 ( .A(n530), .Q(n278) );
  NAND2X4_HV U209 ( .A(n185), .B(n53), .Q(n184) );
  OA211X6_HV U210 ( .A1(n102), .A2(n969), .B1(n56), .C1(n1212), .Q(n55) );
  NAND2X12_HV U211 ( .A(n530), .B(n57), .Q(n56) );
  INVX4_HV U212 ( .A(n1239), .Q(n57) );
  NAND2X6_HV U213 ( .A(n930), .B(acc_out[7]), .Q(n969) );
  NAND2X12_HV U214 ( .A(n1041), .B(n249), .Q(n968) );
  NAND2X12_HV U215 ( .A(n341), .B(n1383), .Q(n967) );
  OAI211X6_HV U216 ( .A1(\thePAT/add_x_23/n25 ), .A2(n64), .B1(n65), .C1(n135), 
        .Q(n526) );
  NAND2X6_HV U217 ( .A(n64), .B(\thePAT/add_x_23/n25 ), .Q(n65) );
  CLKINVX12_HV U218 ( .A(n681), .Q(n1011) );
  NAND3X4_HV U219 ( .A(n1012), .B(n102), .C(n1011), .Q(n1017) );
  OAI21X6_HV U220 ( .A1(n281), .A2(n111), .B1(\DP_OP_104_132_4164/n35 ), .Q(
        \DP_OP_104_132_4164/n33 ) );
  OAI21X6_HV U221 ( .A1(n493), .A2(n1255), .B1(n1254), .Q(n1256) );
  CLKINVX12_HV U222 ( .A(n218), .Q(n399) );
  CLKINVX2_HV U223 ( .A(n501), .Q(n130) );
  NOR2X8_HV U224 ( .A(n322), .B(field_in[4]), .Q(\DP_OP_108_135_5866/n26 ) );
  CLKINVX10_HV U225 ( .A(n655), .Q(n503) );
  CLKINVX8_HV U226 ( .A(n950), .Q(n987) );
  NOR2X8_HV U227 ( .A(n119), .B(acc_out[1]), .Q(n950) );
  INVXL_HV U228 ( .A(n645), .Q(n107) );
  NAND2X3_HV U229 ( .A(\thePAT/opcode_i8[3] ), .B(\thePAT/opcode_i3[0] ), .Q(
        n809) );
  NOR2X6_HV U230 ( .A(n236), .B(n235), .Q(n364) );
  CLKINVX2_HV U231 ( .A(field_out[0]), .Q(n235) );
  NAND2X6_HV U232 ( .A(n675), .B(acc_out[2]), .Q(n962) );
  NOR2X6_HV U233 ( .A(\thePAT/thePC/pc[4] ), .B(\thePAT/pc_immediate[4] ), .Q(
        \thePAT/add_x_23/n44 ) );
  OAI21X3_HV U234 ( .A1(n665), .A2(n677), .B1(n1053), .Q(n855) );
  NAND2X3_HV U235 ( .A(\DP_OP_104_132_4164/n44 ), .B(\DP_OP_104_132_4164/n25 ), 
        .Q(\DP_OP_104_132_4164/n4 ) );
  NAND2X3_HV U236 ( .A(n1041), .B(n127), .Q(n922) );
  BUFX24_HV U237 ( .A(n515), .Q(n397) );
  OAI21X3_HV U238 ( .A1(n1368), .A2(n1367), .B1(n1366), .Q(n1375) );
  NAND2XL_HV U239 ( .A(n982), .B(n389), .Q(n584) );
  CLKINVX8_HV U240 ( .A(n255), .Q(n112) );
  OAI211X3_HV U241 ( .A1(n1156), .A2(n1370), .B1(n695), .C1(n1310), .Q(n1158)
         );
  CLKBUFX2_HV U242 ( .A(\thePAT/add_x_23/n34 ), .Q(n92) );
  NAND2X3_HV U243 ( .A(n329), .B(\thePAT/opcode_i3[2] ), .Q(n698) );
  NOR2X6_HV U244 ( .A(n251), .B(field_in[5]), .Q(n256) );
  CLKINVX2_HV U245 ( .A(n1380), .Q(n1293) );
  CLKBUFX2_HV U246 ( .A(n1040), .Q(n93) );
  CLKINVX2_HV U247 ( .A(\DP_OP_108_135_5866/n26 ), .Q(\DP_OP_108_135_5866/n43 ) );
  CLKINVX4_HV U248 ( .A(n650), .Q(n651) );
  NOR2X6_HV U249 ( .A(n897), .B(n974), .Q(n893) );
  INVXL_HV U250 ( .A(\thePAT/add_x_23/n28 ), .Q(\thePAT/add_x_23/n64 ) );
  NAND2XL_HV U251 ( .A(n684), .B(n678), .Q(n1131) );
  NAND2X3_HV U252 ( .A(n397), .B(n974), .Q(n213) );
  OAI21X3_HV U253 ( .A1(n976), .A2(n167), .B1(\thePAT/acc_alu_b[4] ), .Q(n205)
         );
  CLKINVX2_HV U254 ( .A(n156), .Q(n523) );
  CLKINVX2_HV U255 ( .A(n665), .Q(n1383) );
  NOR2X6_HV U256 ( .A(n513), .B(n1075), .Q(n512) );
  NOR2X6_HV U257 ( .A(\thePAT/field_alu_b[5] ), .B(field_in[5]), .Q(n1292) );
  NAND2X6_HV U258 ( .A(n683), .B(field_in[2]), .Q(n1346) );
  INVXL_HV U259 ( .A(\thePAT/add_x_23/n23 ), .Q(\thePAT/add_x_23/n63 ) );
  NAND3X6_HV U260 ( .A(n254), .B(n554), .C(n300), .Q(n553) );
  NOR2X6_HV U261 ( .A(\thePAT/field_alu_b[6] ), .B(field_in[6]), .Q(n1380) );
  CLKINVX8_HV U262 ( .A(\thePAT/opcode_i8[3] ), .Q(n1422) );
  NAND2X6_HV U263 ( .A(n163), .B(field_in[6]), .Q(n200) );
  INVXL_HV U264 ( .A(reset), .Q(n124) );
  BUFX12_HV U265 ( .A(\thePAT/thePC/pc[2] ), .Q(n79) );
  CLKINVX2_HV U266 ( .A(n882), .Q(n883) );
  CLKINVX2_HV U267 ( .A(\DP_OP_104_132_4164/n4 ), .Q(n89) );
  NAND2X3_HV U268 ( .A(n389), .B(n311), .Q(n580) );
  NOR2X3_HV U269 ( .A(n916), .B(acc_out[0]), .Q(n272) );
  CLKBUFX2_HV U270 ( .A(n662), .Q(n182) );
  CLKINVX2_HV U271 ( .A(n1052), .Q(n221) );
  NOR3X4_HV U272 ( .A(n1077), .B(n1076), .C(n1075), .Q(n1078) );
  NOR2X6_HV U273 ( .A(n1177), .B(n146), .Q(n1178) );
  NOR2X3_HV U274 ( .A(n809), .B(n808), .Q(n238) );
  NOR2X3_HV U275 ( .A(n1368), .B(n1367), .Q(n1271) );
  NAND2XL_HV U276 ( .A(n127), .B(\thePAT/n74 ), .Q(n1243) );
  NAND2X6_HV U277 ( .A(n195), .B(n954), .Q(n194) );
  INVXL_HV U278 ( .A(\thePAT/add_x_23/n44 ), .Q(\thePAT/add_x_23/n66 ) );
  NAND2XL_HV U279 ( .A(\thePAT/add_x_23/n65 ), .B(\thePAT/add_x_23/n40 ), .Q(
        n82) );
  INVXL_HV U280 ( .A(\thePAT/add_x_23/n60 ), .Q(n225) );
  CLKBUFX2_HV U281 ( .A(\thePAT/data_out[0] ), .Q(n692) );
  CLKBUFX2_HV U282 ( .A(\thePAT/data_out[1] ), .Q(n688) );
  CLKBUFX2_HV U283 ( .A(\thePAT/data_out[2] ), .Q(n690) );
  CLKBUFX2_HV U284 ( .A(\thePAT/data_out[3] ), .Q(n687) );
  CLKBUFX2_HV U285 ( .A(\thePAT/data_out[4] ), .Q(n689) );
  CLKBUFX2_HV U286 ( .A(\thePAT/data_out[5] ), .Q(n691) );
  CLKBUFX2_HV U287 ( .A(\thePAT/data_out[6] ), .Q(n694) );
  CLKBUFX2_HV U288 ( .A(\thePAT/data_out[7] ), .Q(n693) );
  INVX24_HV U289 ( .A(n138), .Q(n160) );
  CLKINVX16_HV U290 ( .A(n1392), .Q(\acc_out[0]_BAR ) );
  NAND2XL_HV U291 ( .A(pc[9]), .B(reset), .Q(n287) );
  NAND2X3_HV U292 ( .A(n837), .B(buf_fieldp[5]), .Q(n833) );
  IMUX2XL_HV U293 ( .A(\iBuffer/i_buffer[1][0] ), .B(\iBuffer/i_buffer[0][0] ), 
        .S(n160), .Q(n1514) );
  IMUX2XL_HV U294 ( .A(\iBuffer/i_buffer[1][2] ), .B(\iBuffer/i_buffer[0][2] ), 
        .S(n160), .Q(n1509) );
  IMUX2XL_HV U295 ( .A(\iBuffer/i_buffer[1][5] ), .B(\iBuffer/i_buffer[0][5] ), 
        .S(n160), .Q(n1504) );
  IMUX2XL_HV U296 ( .A(\iBuffer/i_buffer[1][6] ), .B(\iBuffer/i_buffer[0][6] ), 
        .S(n160), .Q(n1502) );
  IMUX2XL_HV U297 ( .A(\iBuffer/i_buffer[1][7] ), .B(\iBuffer/i_buffer[0][7] ), 
        .S(n160), .Q(n1500) );
  IMUX2XL_HV U298 ( .A(\iBuffer/i_buffer[1][8] ), .B(\iBuffer/i_buffer[0][8] ), 
        .S(n160), .Q(n1498) );
  IMUX2XL_HV U299 ( .A(\iBuffer/i_buffer[1][9] ), .B(\iBuffer/i_buffer[0][9] ), 
        .S(n160), .Q(n1496) );
  IMUX2XL_HV U300 ( .A(\iBuffer/i_buffer[1][11] ), .B(
        \iBuffer/i_buffer[0][11] ), .S(n160), .Q(n1492) );
  NAND2XL_HV U301 ( .A(n1060), .B(n249), .Q(n356) );
  NAND3X3_HV U302 ( .A(n444), .B(n295), .C(n728), .Q(n729) );
  OAI211X3_HV U303 ( .A1(n563), .A2(n1375), .B1(n562), .C1(n1376), .Q(n487) );
  NAND2X6_HV U304 ( .A(n666), .B(\thePAT/immediate_i8[0] ), .Q(n452) );
  NAND2X3_HV U305 ( .A(n230), .B(n229), .Q(\thePAT/thePC/N23 ) );
  NAND2X6_HV U306 ( .A(n666), .B(n1523), .Q(n758) );
  NAND2X6_HV U307 ( .A(n440), .B(n949), .Q(n439) );
  NAND2X6_HV U308 ( .A(n586), .B(n949), .Q(n585) );
  NAND2X3_HV U309 ( .A(n837), .B(buf_fieldp[6]), .Q(n835) );
  IMUX2XL_HV U310 ( .A(\iBuffer/i_buffer[1][14] ), .B(
        \iBuffer/i_buffer[0][14] ), .S(n160), .Q(n1487) );
  IMUX2XL_HV U311 ( .A(\iBuffer/i_buffer[1][13] ), .B(
        \iBuffer/i_buffer[0][13] ), .S(n160), .Q(n1489) );
  IMUX2XL_HV U312 ( .A(\iBuffer/i_buffer[1][10] ), .B(
        \iBuffer/i_buffer[0][10] ), .S(n160), .Q(n1494) );
  IMUX2XL_HV U313 ( .A(\iBuffer/i_buffer[1][4] ), .B(\iBuffer/i_buffer[0][4] ), 
        .S(n160), .Q(n1506) );
  CLKINVX6_HV U314 ( .A(\thePAT/n73 ), .Q(acc_out[3]) );
  OA21X6_HV U315 ( .A1(n118), .A2(n59), .B1(\DP_OP_108_135_5866/n38 ), .Q(n129) );
  NAND4X3_HV U316 ( .A(n622), .B(n1307), .C(n517), .D(n1350), .Q(n481) );
  NAND2X3_HV U317 ( .A(n446), .B(n423), .Q(n60) );
  NAND2X3_HV U318 ( .A(n370), .B(\thePAT/add_x_23/n12 ), .Q(n61) );
  NAND2X6_HV U319 ( .A(n61), .B(n556), .Q(n62) );
  OAI211X6_HV U320 ( .A1(n556), .A2(n61), .B1(n62), .C1(n135), .Q(n230) );
  OAI22X3_HV U321 ( .A1(n1372), .A2(n1218), .B1(n1369), .B2(n1368), .Q(n1107)
         );
  NOR2X3_HV U322 ( .A(n674), .B(n1349), .Q(n63) );
  NAND2X3_HV U323 ( .A(n1350), .B(n63), .Q(n1374) );
  NAND2XL_HV U324 ( .A(\thePAT/add_x_23/n63 ), .B(\thePAT/add_x_23/n24 ), .Q(
        n64) );
  OAI21X3_HV U325 ( .A1(n317), .A2(\thePAT/add_x_22/n4 ), .B1(n337), .Q(n66)
         );
  OAI311X3_HV U326 ( .A1(n317), .A2(\thePAT/add_x_22/n4 ), .A3(n337), .B1(n139), .C1(n66), .Q(n229) );
  NOR2X3_HV U327 ( .A(\thePAT/opcode_i3[2] ), .B(\thePAT/opcode_i3[1] ), .Q(
        n67) );
  NAND2X6_HV U328 ( .A(n800), .B(n67), .Q(n805) );
  NOR2X3_HV U329 ( .A(n326), .B(\thePAT/op_mov_regd ), .Q(n68) );
  NAND3X12_HV U330 ( .A(n568), .B(n353), .C(n68), .Q(n136) );
  AND3X8_HV U331 ( .A(n1479), .B(n1478), .C(n320), .Q(n1486) );
  NOR2X3_HV U332 ( .A(n1136), .B(n1311), .Q(n69) );
  OAI211X3_HV U333 ( .A1(n1315), .A2(n69), .B1(n1131), .C1(n1132), .Q(n70) );
  OR2X6_HV U334 ( .A(n1139), .B(n70), .Q(n271) );
  AND2X8_HV U335 ( .A(n820), .B(n813), .Q(n423) );
  NAND2X12_HV U336 ( .A(pc[6]), .B(reset), .Q(n1445) );
  NAND3X6_HV U337 ( .A(n148), .B(n509), .C(n1445), .Q(\thePAT/n9 ) );
  CLKINVX4_HV U338 ( .A(n1229), .Q(n71) );
  NAND2X6_HV U339 ( .A(n165), .B(n71), .Q(n1323) );
  XOR2X1_HV U340 ( .A(\thePAT/add_x_23/n55 ), .B(n72), .Q(
        \thePAT/thePC/pcAdd[2] ) );
  NAND3X3_HV U341 ( .A(n1211), .B(n1212), .C(n674), .Q(n73) );
  NAND2X3_HV U342 ( .A(n73), .B(n1376), .Q(n533) );
  OAI21X3_HV U343 ( .A1(n1303), .A2(n363), .B1(n1302), .Q(n74) );
  NAND2X3_HV U344 ( .A(n1300), .B(n1301), .Q(n75) );
  AOI21X8_HV U345 ( .A1(n1304), .A2(n75), .B1(n74), .Q(n1337) );
  NOR2X4_HV U346 ( .A(\thePAT/add_x_22/n23 ), .B(n630), .Q(n76) );
  XNOR2X2_HV U347 ( .A(n76), .B(n639), .Q(\thePAT/thePC/pcInc[5] ) );
  NAND2XL_HV U348 ( .A(n160), .B(reset), .Q(n1436) );
  INVXL_HV U349 ( .A(n818), .Q(n77) );
  OAI22X3_HV U350 ( .A1(n819), .A2(n275), .B1(n297), .B2(n77), .Q(
        \thePAT/dest_dmem ) );
  IMUX2XL_HV U351 ( .A(n1459), .B(n1566), .S(n160), .Q(\iBuffer/n38 ) );
  IMUX2XL_HV U352 ( .A(n1461), .B(n1564), .S(n160), .Q(\iBuffer/n36 ) );
  IMUX2XL_HV U353 ( .A(n1463), .B(n1562), .S(n160), .Q(\iBuffer/n34 ) );
  IMUX2XL_HV U354 ( .A(n1465), .B(n1560), .S(n160), .Q(\iBuffer/n32 ) );
  NAND2X3_HV U355 ( .A(pc[4]), .B(reset), .Q(n1443) );
  NAND2X3_HV U356 ( .A(pc[8]), .B(reset), .Q(n1447) );
  INVXL_HV U357 ( .A(n821), .Q(n78) );
  AO21X1_HV U358 ( .A1(n423), .A2(n78), .B1(\thePAT/op_setb ), .Q(
        \thePAT/source_imm ) );
  AO21X1_HV U359 ( .A1(field_write_en), .A2(n459), .B1(n1303), .Q(
        \thePAT/n809 ) );
  NAND2XL_HV U360 ( .A(pc[1]), .B(reset), .Q(n1437) );
  CLKINVX2_HV U361 ( .A(\thePAT/thePC/N4 ), .Q(n1438) );
  NAND2X3_HV U362 ( .A(pc[2]), .B(reset), .Q(n1439) );
  IMUX2XL_HV U363 ( .A(n1467), .B(n1558), .S(n160), .Q(\iBuffer/n30 ) );
  IMUX2XL_HV U364 ( .A(n1469), .B(n1556), .S(n160), .Q(\iBuffer/n28 ) );
  IMUX2XL_HV U365 ( .A(n1471), .B(n1554), .S(n160), .Q(\iBuffer/n26 ) );
  IMUX2XL_HV U366 ( .A(n1472), .B(n1553), .S(n160), .Q(\iBuffer/n25 ) );
  IMUX2XL_HV U367 ( .A(n1473), .B(n1552), .S(n160), .Q(\iBuffer/n24 ) );
  IMUX2XL_HV U368 ( .A(n1474), .B(n1551), .S(n160), .Q(\iBuffer/n23 ) );
  IMUX2XL_HV U369 ( .A(n1475), .B(n1550), .S(n160), .Q(\iBuffer/n22 ) );
  IMUX2XL_HV U370 ( .A(n1476), .B(n1549), .S(n160), .Q(\iBuffer/n21 ) );
  IMUX2XL_HV U371 ( .A(n1477), .B(n1548), .S(n160), .Q(\iBuffer/n20 ) );
  IMUX2XL_HV U372 ( .A(n1480), .B(n1547), .S(n160), .Q(\iBuffer/n19 ) );
  IMUX2XL_HV U373 ( .A(n1481), .B(n1546), .S(n160), .Q(\iBuffer/n18 ) );
  IMUX2XL_HV U374 ( .A(n1482), .B(n1545), .S(n160), .Q(\iBuffer/n17 ) );
  IMUX2XL_HV U375 ( .A(n1483), .B(n1544), .S(n160), .Q(\iBuffer/n16 ) );
  IMUX2XL_HV U376 ( .A(n1484), .B(n1543), .S(n160), .Q(\iBuffer/n15 ) );
  IMUX2XL_HV U377 ( .A(n1488), .B(n1542), .S(n160), .Q(\iBuffer/n14 ) );
  IMUX2XL_HV U378 ( .A(n1490), .B(n1541), .S(n160), .Q(\iBuffer/n13 ) );
  IMUX2XL_HV U379 ( .A(n1491), .B(n1540), .S(n160), .Q(\iBuffer/n12 ) );
  IMUX2XL_HV U380 ( .A(n1493), .B(n1539), .S(n160), .Q(\iBuffer/n11 ) );
  CLKINVX8_HV U381 ( .A(n839), .Q(n80) );
  CLKINVX12_HV U382 ( .A(n1572), .Q(n839) );
  AOI21X6_HV U383 ( .A1(\thePAT/add_x_23/n46 ), .A2(\thePAT/add_x_23/n26 ), 
        .B1(\thePAT/add_x_23/n27 ), .Q(\thePAT/add_x_23/n25 ) );
  NAND2X6_HV U384 ( .A(n302), .B(\thePAT/add_x_23/n17 ), .Q(
        \thePAT/add_x_23/n2 ) );
  XNOR2X2_HV U385 ( .A(n81), .B(n82), .Q(n615) );
  OAI21X3_HV U386 ( .A1(\thePAT/add_x_23/n47 ), .A2(\thePAT/add_x_23/n44 ), 
        .B1(\thePAT/add_x_23/n45 ), .Q(n81) );
  CLKBUFX2_HV U387 ( .A(\thePAT/op_setb ), .Q(n83) );
  NOR3X12_HV U388 ( .A(n805), .B(n296), .C(n316), .Q(\thePAT/op_setb ) );
  NAND2X12_HV U389 ( .A(n625), .B(field_in[2]), .Q(n252) );
  NOR2X6_HV U390 ( .A(n625), .B(field_in[2]), .Q(\DP_OP_108_135_5866/n33 ) );
  NOR2X4_HV U391 ( .A(n705), .B(n658), .Q(n793) );
  OAI211X6_HV U392 ( .A1(n665), .A2(n278), .B1(n1046), .C1(n1033), .Q(n1039)
         );
  NOR2X12_HV U393 ( .A(n1571), .B(\thePAT/acc_alu_b[3] ), .Q(
        \DP_OP_104_132_4164/n31 ) );
  NAND2X6_HV U394 ( .A(n1571), .B(\thePAT/acc_alu_b[3] ), .Q(
        \DP_OP_104_132_4164/n32 ) );
  CLKINVX8_HV U395 ( .A(\thePAT/n1 ), .Q(n483) );
  CLKINVX8_HV U396 ( .A(n503), .Q(n84) );
  INVX32_HV U397 ( .A(n250), .Q(n85) );
  BUFX32_HV U398 ( .A(n697), .Q(n250) );
  NAND2X6_HV U399 ( .A(n982), .B(n582), .Q(n581) );
  NAND2X6_HV U400 ( .A(n389), .B(n583), .Q(n582) );
  XNOR2X2_HV U401 ( .A(n86), .B(n118), .Q(n1517) );
  AND2X4_HV U402 ( .A(n647), .B(\DP_OP_108_135_5866/n38 ), .Q(n86) );
  NAND2X6_HV U403 ( .A(n148), .B(n509), .Q(\thePAT/thePC/N9 ) );
  CLKBUFX12_HV U404 ( .A(\thePAT/opcode_i8[1] ), .Q(n87) );
  NAND3X8_HV U405 ( .A(n1003), .B(n1025), .C(n1045), .Q(n596) );
  NOR2X12_HV U406 ( .A(n507), .B(n504), .Q(n587) );
  INVX8_HV U407 ( .A(\DP_OP_104_132_4164/n26 ), .Q(n88) );
  CLKBUFX6_HV U408 ( .A(n920), .Q(n247) );
  NAND2X6_HV U409 ( .A(\DP_OP_104_132_4164/n26 ), .B(\DP_OP_104_132_4164/n4 ), 
        .Q(n90) );
  NAND2X12_HV U410 ( .A(n88), .B(n89), .Q(n91) );
  NAND2X12_HV U411 ( .A(n91), .B(n90), .Q(\C1/DATA1_5 ) );
  NOR2X6_HV U412 ( .A(n293), .B(\thePAT/op_sub_subm_regd_2 ), .Q(n1104) );
  OA22X6_HV U413 ( .A1(n249), .A2(n907), .B1(n940), .B2(n916), .Q(n910) );
  NAND2X6_HV U414 ( .A(n1011), .B(n916), .Q(n907) );
  NAND2X8_HV U415 ( .A(\thePAT/acc_alu_b[2] ), .B(n839), .Q(n1064) );
  OAI21X8_HV U416 ( .A1(n868), .A2(n867), .B1(n866), .Q(n462) );
  NOR2X4_HV U417 ( .A(n127), .B(n1042), .Q(n903) );
  AOI22X6_HV U418 ( .A1(n438), .A2(n850), .B1(n862), .B2(n954), .Q(n437) );
  NAND2X12_HV U419 ( .A(n885), .B(n152), .Q(n470) );
  OAI211X6_HV U420 ( .A1(n180), .A2(n584), .B1(n578), .C1(n579), .Q(n586) );
  NOR2X8_HV U421 ( .A(n1570), .B(\thePAT/acc_alu_b[5] ), .Q(
        \DP_OP_104_132_4164/n24 ) );
  NOR2X12_HV U422 ( .A(n947), .B(n589), .Q(n588) );
  NAND3X8_HV U423 ( .A(n351), .B(n946), .C(n303), .Q(n589) );
  CLKINVX8_HV U424 ( .A(\thePAT/data_read_adr[0] ), .Q(n402) );
  OR3X8_HV U425 ( .A(\thePAT/data_read_adr[1] ), .B(n658), .C(n702), .Q(n276)
         );
  NAND2X3_HV U426 ( .A(n167), .B(\thePAT/field_alu_b[3] ), .Q(n179) );
  NAND4X6_HV U427 ( .A(n1162), .B(n1161), .C(n1325), .D(n1376), .Q(n1167) );
  NOR2X6_HV U428 ( .A(n1158), .B(n1157), .Q(n1162) );
  NAND4X8_HV U429 ( .A(n856), .B(n234), .C(n857), .D(n233), .Q(n436) );
  NAND3X6_HV U430 ( .A(n853), .B(n854), .C(n970), .Q(n234) );
  NAND2X12_HV U431 ( .A(n1060), .B(n108), .Q(n233) );
  CLKINVX6_HV U432 ( .A(n1571), .Q(n838) );
  OAI21X6_HV U433 ( .A1(\thePAT/add_x_23/n23 ), .A2(\thePAT/add_x_23/n31 ), 
        .B1(\thePAT/add_x_23/n24 ), .Q(\thePAT/add_x_23/n22 ) );
  CLKINVX32_HV U434 ( .A(n684), .Q(n165) );
  NAND2X12_HV U435 ( .A(n1408), .B(n94), .Q(n1417) );
  NOR2X6_HV U436 ( .A(\thePAT/n80 ), .B(n306), .Q(n94) );
  CLKINVX12_HV U437 ( .A(n1407), .Q(n1408) );
  NAND2X6_HV U438 ( .A(n1357), .B(n241), .Q(n1365) );
  BUFX24_HV U439 ( .A(\DP_OP_108_135_5866/n52 ), .Q(n241) );
  OAI22X3_HV U440 ( .A1(n1347), .A2(n1348), .B1(n1370), .B2(n1346), .Q(n558)
         );
  OR2X6_HV U441 ( .A(n1347), .B(n1308), .Q(n1314) );
  OA211X6_HV U442 ( .A1(n1235), .A2(n493), .B1(n1234), .C1(n569), .Q(n263) );
  NAND2X8_HV U443 ( .A(n675), .B(n695), .Q(n1029) );
  OR2X8_HV U444 ( .A(n620), .B(n123), .Q(n148) );
  NAND3X3_HV U445 ( .A(n1326), .B(n241), .C(n1325), .Q(n475) );
  NAND2X6_HV U446 ( .A(n610), .B(n1376), .Q(n264) );
  INVX24_HV U447 ( .A(n1376), .Q(n493) );
  INVX32_HV U448 ( .A(n95), .Q(n1041) );
  INVX24_HV U449 ( .A(n1414), .Q(n96) );
  CLKINVX32_HV U450 ( .A(n96), .Q(n97) );
  INVX24_HV U451 ( .A(n1411), .Q(n98) );
  CLKINVX32_HV U452 ( .A(n98), .Q(n99) );
  NOR2X6_HV U453 ( .A(n1052), .B(n114), .Q(n593) );
  NAND2X8_HV U454 ( .A(n958), .B(n102), .Q(n1052) );
  CLKINVX6_HV U455 ( .A(n621), .Q(n622) );
  NOR3X6_HV U456 ( .A(n1360), .B(n1265), .C(n1358), .Q(n1258) );
  OA21X6_HV U457 ( .A1(n100), .A2(n101), .B1(n1277), .Q(n394) );
  AND3X4_HV U458 ( .A(n1224), .B(n273), .C(n1223), .Q(n100) );
  AND2X4_HV U459 ( .A(n163), .B(field_in[2]), .Q(n101) );
  CLKINVX6_HV U460 ( .A(n1364), .Q(n1277) );
  CLKINVX8_HV U461 ( .A(n1035), .Q(n971) );
  BUFX24_HV U462 ( .A(n660), .Q(n102) );
  AOI21X6_HV U463 ( .A1(n1067), .A2(n1066), .B1(n1065), .Q(n1070) );
  NAND2X6_HV U464 ( .A(n340), .B(n501), .Q(n500) );
  NAND2X6_HV U465 ( .A(n455), .B(n367), .Q(n454) );
  OA21X2_HV U466 ( .A1(n907), .A2(n80), .B1(n993), .Q(n352) );
  NAND2X6_HV U467 ( .A(n399), .B(n828), .Q(n286) );
  NAND3X3_HV U468 ( .A(n675), .B(n159), .C(n167), .Q(n896) );
  NAND2X12_HV U469 ( .A(n462), .B(n460), .Q(n466) );
  NAND2X6_HV U470 ( .A(n382), .B(n461), .Q(n460) );
  OA21X6_HV U471 ( .A1(n1294), .A2(n1299), .B1(n1382), .Q(n1295) );
  AOI21X6_HV U472 ( .A1(n675), .A2(n849), .B1(n436), .Q(n435) );
  OR2X8_HV U473 ( .A(n1171), .B(n1308), .Q(n1118) );
  OAI211X3_HV U474 ( .A1(\DP_OP_108_135_5866/n67 ), .A2(field_in[1]), .B1(n684), .C1(n1116), .Q(n1117) );
  NAND2X12_HV U475 ( .A(n503), .B(\thePAT/dest_acc_regd ), .Q(n447) );
  NAND2X12_HV U476 ( .A(n522), .B(\DP_OP_104_132_4164/n28 ), .Q(
        \DP_OP_104_132_4164/n26 ) );
  NOR3X8_HV U477 ( .A(n942), .B(n113), .C(n941), .Q(n945) );
  CLKINVX12_HV U478 ( .A(n681), .Q(n105) );
  INVX24_HV U479 ( .A(n105), .Q(n106) );
  INVX8_HV U480 ( .A(n1042), .Q(n530) );
  OA21X6_HV U481 ( .A1(n679), .A2(n1369), .B1(n1351), .Q(n1355) );
  NAND2X6_HV U482 ( .A(n648), .B(n649), .Q(n1022) );
  CLKINVX12_HV U483 ( .A(n654), .Q(n842) );
  AND2X4_HV U484 ( .A(n353), .B(n568), .Q(n1099) );
  NAND3X6_HV U485 ( .A(n11), .B(n660), .C(n682), .Q(n1042) );
  CLKBUFX6_HV U486 ( .A(n106), .Q(n114) );
  CLKINVX3_HV U487 ( .A(n677), .Q(n559) );
  CLKINVX6_HV U488 ( .A(n828), .Q(n220) );
  NOR2X6_HV U489 ( .A(n1315), .B(n136), .Q(n1221) );
  NOR2X6_HV U490 ( .A(n136), .B(n674), .Q(n409) );
  OAI21X6_HV U491 ( .A1(n677), .A2(n1174), .B1(n679), .Q(n1176) );
  OAI21X6_HV U492 ( .A1(n677), .A2(n241), .B1(n679), .Q(n1195) );
  NAND3X6_HV U493 ( .A(n307), .B(n611), .C(n375), .Q(n610) );
  NAND2X6_HV U494 ( .A(n397), .B(n151), .Q(n892) );
  CLKINVX4_HV U495 ( .A(n665), .Q(n108) );
  NAND2X6_HV U496 ( .A(n1220), .B(n1219), .Q(n1222) );
  AO31X4_HV U497 ( .A1(n918), .A2(n917), .A3(n1011), .B1(n102), .Q(n923) );
  NAND4X4_HV U498 ( .A(n906), .B(n905), .C(n972), .D(n904), .Q(n913) );
  OAI21X6_HV U499 ( .A1(\DP_OP_108_135_5866/n1 ), .A2(\DP_OP_108_135_5866/n19 ), .B1(\DP_OP_108_135_5866/n20 ), .Q(n497) );
  CLKINVX6_HV U500 ( .A(n112), .Q(n109) );
  CLKBUFX6_HV U501 ( .A(n686), .Q(acc_out[5]) );
  NAND2X6_HV U502 ( .A(n954), .B(n1048), .Q(n1049) );
  OAI21X6_HV U503 ( .A1(n945), .A2(n944), .B1(n675), .Q(n946) );
  NOR2X6_HV U504 ( .A(n294), .B(field_in[0]), .Q(n118) );
  OA21X3_HV U505 ( .A1(acc_out[7]), .A2(n312), .B1(n877), .Q(n882) );
  NAND2X6_HV U506 ( .A(acc_out[7]), .B(n312), .Q(n877) );
  INVX1_HV U507 ( .A(\DP_OP_108_135_5866/n30 ), .Q(n110) );
  NOR2X12_HV U508 ( .A(n664), .B(field_in[3]), .Q(\DP_OP_108_135_5866/n30 ) );
  NAND2X6_HV U509 ( .A(n1206), .B(n1205), .Q(n1208) );
  CLKINVX4_HV U510 ( .A(n568), .Q(n448) );
  CLKINVX2_HV U511 ( .A(\DP_OP_104_132_4164/n47 ), .Q(n111) );
  NOR2X6_HV U512 ( .A(\thePAT/acc_alu_b[2] ), .B(n1572), .Q(
        \DP_OP_104_132_4164/n34 ) );
  CLKBUFX6_HV U513 ( .A(n1073), .Q(n116) );
  NOR2X3_HV U514 ( .A(n654), .B(n829), .Q(n863) );
  OAI21X6_HV U515 ( .A1(n830), .A2(n126), .B1(n172), .Q(n171) );
  CLKINVX12_HV U516 ( .A(n290), .Q(\acc_out[1]_BAR ) );
  OAI21X6_HV U517 ( .A1(field_in[4]), .A2(n629), .B1(n1325), .Q(n574) );
  NAND2X6_HV U518 ( .A(n575), .B(\DP_OP_108_135_5866/n52 ), .Q(n629) );
  NAND2X6_HV U519 ( .A(\thePAT/thePC/pcAdd[8] ), .B(n135), .Q(n1435) );
  OAI22X8_HV U520 ( .A1(n1028), .A2(n604), .B1(n606), .B2(n603), .Q(n602) );
  BUFX12_HV U521 ( .A(n998), .Q(n113) );
  NAND3X6_HV U522 ( .A(n1137), .B(n1307), .C(\thePAT/n57 ), .Q(n1349) );
  NOR3X6_HV U523 ( .A(n1222), .B(n268), .C(n267), .Q(n266) );
  INVX24_HV U524 ( .A(n128), .Q(n1310) );
  AND2X6_HV U525 ( .A(n128), .B(n1345), .Q(n344) );
  BUFX24_HV U526 ( .A(n289), .Q(n115) );
  NAND3X12_HV U527 ( .A(n588), .B(n587), .C(n585), .Q(\thePAT/n784 ) );
  NAND4X6_HV U528 ( .A(n514), .B(n517), .C(n369), .D(n1016), .Q(n515) );
  AND3X8_HV U529 ( .A(\C1/DATA1_5 ), .B(n1031), .C(n1030), .Q(n947) );
  CLKINVX10_HV U530 ( .A(\thePAT/acc_alu_b[1] ), .Q(n231) );
  NAND3X12_HV U531 ( .A(n1167), .B(n1165), .C(n1166), .Q(n1168) );
  NOR2X6_HV U532 ( .A(n574), .B(n493), .Q(n573) );
  OR2X6_HV U533 ( .A(\DP_OP_108_135_5866/n67 ), .B(n1348), .Q(n1135) );
  NAND3X3_HV U534 ( .A(\DP_OP_108_135_5866/n67 ), .B(n115), .C(field_in[7]), 
        .Q(n1199) );
  NAND2X8_HV U535 ( .A(\DP_OP_108_135_5866/n67 ), .B(field_in[0]), .Q(n1134)
         );
  OAI211X8_HV U536 ( .A1(n38), .A2(n760), .B1(n759), .C1(n758), .Q(
        \thePAT/N41 ) );
  NOR2X8_HV U537 ( .A(n703), .B(n298), .Q(n791) );
  AOI21X6_HV U538 ( .A1(n1379), .A2(n1378), .B1(n1377), .Q(n495) );
  OAI21X6_HV U539 ( .A1(n1292), .A2(n1291), .B1(n1290), .Q(n1377) );
  NAND3X3_HV U540 ( .A(n957), .B(n93), .C(n675), .Q(n187) );
  NAND2X12_HV U541 ( .A(n415), .B(n980), .Q(n414) );
  NAND4X8_HV U542 ( .A(n212), .B(n209), .C(n206), .D(n205), .Q(n415) );
  NOR2X4_HV U543 ( .A(n705), .B(\thePAT/data_read_adr[0] ), .Q(n792) );
  OAI211X6_HV U544 ( .A1(n741), .A2(n799), .B1(n456), .C1(n454), .Q(
        \thePAT/N43 ) );
  CLKBUFX2_HV U545 ( .A(n643), .Q(n117) );
  NAND2X3_HV U546 ( .A(\DP_OP_108_135_5866/n21 ), .B(n371), .Q(
        \DP_OP_108_135_5866/n12 ) );
  NOR2X8_HV U547 ( .A(\DP_OP_108_135_5866/n26 ), .B(\DP_OP_108_135_5866/n23 ), 
        .Q(\DP_OP_108_135_5866/n21 ) );
  AND3X6_HV U548 ( .A(\DP_OP_108_135_5866/n67 ), .B(n1143), .C(field_in[0]), 
        .Q(n554) );
  NAND2X6_HV U549 ( .A(n1148), .B(n85), .Q(n1347) );
  NAND2X12_HV U550 ( .A(n872), .B(n871), .Q(n829) );
  AOI21X8_HV U551 ( .A1(n1221), .A2(n1169), .B1(n1168), .Q(n1182) );
  NAND3X4_HV U552 ( .A(n109), .B(n684), .C(n294), .Q(n1201) );
  CLKINVX4_HV U553 ( .A(n1070), .Q(n1072) );
  OR2X8_HV U554 ( .A(n599), .B(n651), .Q(n598) );
  NAND2X6_HV U555 ( .A(n254), .B(n1089), .Q(n1090) );
  NAND2X3_HV U556 ( .A(n1205), .B(n254), .Q(n1126) );
  AOI21X3_HV U557 ( .A1(n1041), .A2(n1392), .B1(n50), .Q(n120) );
  CLKINVX4_HV U558 ( .A(n955), .Q(n906) );
  CLKBUFX2_HV U559 ( .A(n525), .Q(n244) );
  NAND2X12_HV U560 ( .A(n121), .B(n122), .Q(n1088) );
  CLKINVX24_HV U561 ( .A(n683), .Q(\DP_OP_108_135_5866/n52 ) );
  NAND3X6_HV U562 ( .A(n1338), .B(n1337), .C(n1336), .Q(\thePAT/n764 ) );
  NAND2X6_HV U563 ( .A(n1424), .B(n124), .Q(n123) );
  NAND2X12_HV U564 ( .A(n1454), .B(n1423), .Q(n1425) );
  CLKINVX8_HV U565 ( .A(n1425), .Q(n1424) );
  CLKBUFX2_HV U566 ( .A(\DP_OP_108_135_5866/n33 ), .Q(n277) );
  CLKINVX6_HV U567 ( .A(\thePAT/n1 ), .Q(n125) );
  INVX24_HV U568 ( .A(n125), .Q(n126) );
  BUFX24_HV U569 ( .A(\thePAT/n73 ), .Q(n127) );
  NAND2X12_HV U570 ( .A(n681), .B(acc_out[1]), .Q(\DP_OP_104_132_4164/n39 ) );
  NOR2X12_HV U571 ( .A(n165), .B(n255), .Q(n128) );
  CLKBUFX32_HV U572 ( .A(\thePAT/field_alu_b[1] ), .Q(n684) );
  NOR2X8_HV U573 ( .A(n684), .B(n625), .Q(n1148) );
  NAND2X6_HV U574 ( .A(n374), .B(n143), .Q(n438) );
  CLKINVX10_HV U575 ( .A(n1066), .Q(n501) );
  NAND2X8_HV U576 ( .A(n119), .B(acc_out[1]), .Q(n1066) );
  OR2X3_HV U577 ( .A(n681), .B(acc_out[1]), .Q(n131) );
  NAND2X12_HV U578 ( .A(n1041), .B(acc_out[2]), .Q(n972) );
  AND3X8_HV U579 ( .A(n194), .B(n966), .C(n964), .Q(n193) );
  INVX24_HV U580 ( .A(\thePAT/n76 ), .Q(n1392) );
  AND2X6_HV U581 ( .A(n884), .B(n883), .Q(n152) );
  AND2X6_HV U582 ( .A(n409), .B(n1344), .Q(n133) );
  OA22X3_HV U583 ( .A1(n1145), .A2(n677), .B1(n679), .B2(n1367), .Q(n134) );
  NOR2X8_HV U584 ( .A(n1360), .B(n651), .Q(n1030) );
  AND2X6_HV U585 ( .A(n673), .B(n633), .Q(n137) );
  NOR2X12_HV U586 ( .A(n1424), .B(reset), .Q(n139) );
  OR2X6_HV U587 ( .A(n518), .B(n618), .Q(n140) );
  CLKINVX4_HV U588 ( .A(n1368), .Q(n162) );
  AND3X2_HV U589 ( .A(n87), .B(\thePAT/opcode_i8[2] ), .C(
        \thePAT/opcode_i3[2] ), .Q(n144) );
  OR3X3_HV U590 ( .A(n251), .B(field_in[3]), .C(n674), .Q(n145) );
  AND2X4_HV U591 ( .A(n616), .B(n1218), .Q(n146) );
  AND2X6_HV U592 ( .A(n1296), .B(n1382), .Q(n149) );
  OA21X3_HV U593 ( .A1(n677), .A2(n916), .B1(n679), .Q(n151) );
  CLKINVX8_HV U594 ( .A(n425), .Q(n666) );
  CLKINVX6_HV U595 ( .A(n444), .Q(n799) );
  CLKINVX6_HV U596 ( .A(n1029), .Q(n911) );
  OA21X6_HV U597 ( .A1(n677), .A2(n102), .B1(n679), .Q(n153) );
  AND2X8_HV U598 ( .A(n297), .B(\thePAT/n35 ), .Q(n154) );
  INVX1_HV U599 ( .A(n243), .Q(\thePAT/thePC/N3 ) );
  AOI22X3_HV U600 ( .A1(n139), .A2(n627), .B1(n135), .B2(n391), .Q(n243) );
  CLKINVX4_HV U601 ( .A(\thePAT/n75 ), .Q(n290) );
  NOR2X12_HV U602 ( .A(n14), .B(\thePAT/acc_alu_b[4] ), .Q(n156) );
  OR2X8_HV U603 ( .A(n1114), .B(n1115), .Q(n157) );
  OR2X6_HV U604 ( .A(n1323), .B(n1327), .Q(n158) );
  NAND2X6_HV U605 ( .A(n581), .B(n580), .Q(n579) );
  OR2X6_HV U606 ( .A(n1139), .B(n1376), .Q(n304) );
  OA21X3_HV U607 ( .A1(n1008), .A2(n1239), .B1(n925), .Q(n351) );
  OAI21X8_HV U608 ( .A1(n1364), .A2(n1365), .B1(n561), .Q(n486) );
  NAND2X12_HV U609 ( .A(n616), .B(n1369), .Q(n561) );
  NAND2X6_HV U610 ( .A(n199), .B(n198), .Q(n1319) );
  CLKINVX8_HV U611 ( .A(n269), .Q(n1339) );
  NAND2X6_HV U612 ( .A(n228), .B(n634), .Q(n269) );
  NAND2X3_HV U613 ( .A(n216), .B(n215), .Q(n1204) );
  NAND2X3_HV U614 ( .A(n162), .B(field_in[5]), .Q(n216) );
  NAND2X6_HV U615 ( .A(n1251), .B(n254), .Q(n1206) );
  NOR2X6_HV U616 ( .A(n220), .B(n646), .Q(n219) );
  NOR2X6_HV U617 ( .A(n237), .B(n810), .Q(n818) );
  NAND2X3_HV U618 ( .A(n144), .B(n238), .Q(n237) );
  NAND2X6_HV U619 ( .A(pc[7]), .B(reset), .Q(n1446) );
  OR2X8_HV U620 ( .A(\thePAT/n78 ), .B(\thePAT/n79 ), .Q(n1409) );
  AND2X3_HV U621 ( .A(pc[5]), .B(reset), .Q(n279) );
  BUFX24_HV U622 ( .A(n1569), .Q(acc_out[7]) );
  BUFX32_HV U623 ( .A(n682), .Q(n159) );
  NAND2X6_HV U624 ( .A(pc[3]), .B(reset), .Q(n1441) );
  CLKINVX4_HV U625 ( .A(n283), .Q(n284) );
  AND2X6_HV U626 ( .A(\thePAT/opcode_i0[1] ), .B(\thePAT/opcode_i0[3] ), .Q(
        n329) );
  NAND3X6_HV U627 ( .A(n546), .B(n545), .C(n542), .Q(\thePAT/n770 ) );
  NAND3X6_HV U628 ( .A(n473), .B(n480), .C(n1122), .Q(\thePAT/n768 ) );
  NAND2X6_HV U629 ( .A(n1319), .B(n1318), .Q(n1335) );
  OAI21X6_HV U630 ( .A1(n1278), .A2(n1279), .B1(n176), .Q(n1280) );
  NAND3X6_HV U631 ( .A(n547), .B(n544), .C(n339), .Q(n543) );
  NAND3X6_HV U632 ( .A(n425), .B(n715), .C(n295), .Q(n717) );
  NAND2X6_HV U633 ( .A(n227), .B(n223), .Q(\thePAT/thePC/N4 ) );
  NAND2X6_HV U634 ( .A(n1427), .B(n1426), .Q(\thePAT/thePC/N5 ) );
  NAND2X8_HV U635 ( .A(n1432), .B(n614), .Q(\thePAT/thePC/N8 ) );
  NAND2X6_HV U636 ( .A(n1317), .B(n1316), .Q(n1318) );
  NAND3X6_HV U637 ( .A(n230), .B(n229), .C(n287), .Q(\thePAT/n6 ) );
  OA21X6_HV U638 ( .A1(n153), .A2(n962), .B1(n956), .Q(n188) );
  NAND3X3_HV U639 ( .A(n222), .B(n911), .C(n221), .Q(n1063) );
  NAND2X3_HV U640 ( .A(n1030), .B(n239), .Q(n192) );
  NAND3X6_HV U641 ( .A(n145), .B(n134), .C(n179), .Q(n1103) );
  INVX8_HV U642 ( .A(n1344), .Q(n538) );
  NAND2X8_HV U643 ( .A(n910), .B(n909), .Q(n978) );
  NAND3X6_HV U644 ( .A(n1314), .B(n1313), .C(n1312), .Q(n1317) );
  CLKINVX12_HV U645 ( .A(n140), .Q(n616) );
  CLKINVX24_HV U646 ( .A(n484), .Q(n675) );
  OR2X6_HV U647 ( .A(n558), .B(n344), .Q(n560) );
  INVX6_HV U648 ( .A(n217), .Q(n215) );
  NAND2X6_HV U649 ( .A(n246), .B(field_in[7]), .Q(n245) );
  CLKINVX6_HV U650 ( .A(n551), .Q(n552) );
  INVX3_HV U651 ( .A(n812), .Q(n822) );
  NAND2X6_HV U652 ( .A(n250), .B(n613), .Q(n612) );
  INVX8_HV U653 ( .A(n1286), .Q(n1287) );
  CLKINVX16_HV U654 ( .A(n276), .Q(n788) );
  XNOR2X2_HV U655 ( .A(n250), .B(field_in[0]), .Q(n1516) );
  CLKINVX6_HV U656 ( .A(n1372), .Q(n163) );
  OR2X6_HV U657 ( .A(acc_out[7]), .B(\thePAT/acc_alu_b[7] ), .Q(n347) );
  CLKINVX3_HV U658 ( .A(\DP_OP_104_132_4164/n18 ), .Q(\DP_OP_104_132_4164/n16 ) );
  CLKINVX10_HV U659 ( .A(n1022), .Q(n164) );
  CLKINVX6_HV U660 ( .A(n661), .Q(n662) );
  CLKINVX12_HV U661 ( .A(n653), .Q(n654) );
  CLKINVX4_HV U662 ( .A(\thePAT/data_write ), .Q(n1394) );
  BUFX24_HV U663 ( .A(n1570), .Q(n686) );
  CLKINVX10_HV U664 ( .A(\thePAT/field_alu_b[0] ), .Q(n697) );
  BUFX32_HV U665 ( .A(\thePAT/acc_alu_b[0] ), .Q(n682) );
  NOR2X12_HV U666 ( .A(\thePAT/thePC/pc[5] ), .B(\thePAT/pc_immediate[5] ), 
        .Q(\thePAT/add_x_23/n39 ) );
  CLKINVX4_HV U667 ( .A(n631), .Q(n181) );
  NAND2X6_HV U668 ( .A(n183), .B(field_in[5]), .Q(n1306) );
  NAND2X6_HV U669 ( .A(n183), .B(field_in[3]), .Q(n1220) );
  NOR2X3_HV U670 ( .A(n1272), .B(n217), .Q(n1154) );
  NAND2X12_HV U671 ( .A(n180), .B(n577), .Q(n578) );
  NAND2X12_HV U672 ( .A(n300), .B(n1143), .Q(n555) );
  NAND2X12_HV U673 ( .A(n684), .B(field_in[1]), .Q(n1205) );
  NOR2X6_HV U674 ( .A(n1008), .B(\acc_out[1]_BAR ), .Q(n606) );
  OAI21X6_HV U675 ( .A1(\DP_OP_108_135_5866/n1 ), .A2(\DP_OP_108_135_5866/n26 ), .B1(\DP_OP_108_135_5866/n27 ), .Q(n410) );
  CLKINVX2_HV U676 ( .A(field_in[2]), .Q(n1308) );
  CLKINVX2_HV U677 ( .A(field_in[1]), .Q(n1348) );
  NOR2X8_HV U678 ( .A(n1372), .B(n1367), .Q(n217) );
  CLKINVX2_HV U679 ( .A(field_in[3]), .Q(n1367) );
  CLKINVX2_HV U680 ( .A(field_in[4]), .Q(n1218) );
  CLKINVX2_HV U681 ( .A(field_in[0]), .Q(n1265) );
  NAND2X6_HV U682 ( .A(n166), .B(n936), .Q(n567) );
  CLKINVX4_HV U683 ( .A(n1097), .Q(n166) );
  NAND2X8_HV U684 ( .A(n991), .B(n992), .Q(n1097) );
  NOR2X8_HV U685 ( .A(n683), .B(n684), .Q(n1138) );
  OAI22X6_HV U686 ( .A1(n1309), .A2(n1348), .B1(n629), .B2(n1218), .Q(n267) );
  NAND3X6_HV U687 ( .A(n1520), .B(n1296), .C(n1344), .Q(n1338) );
  BUFX12_HV U688 ( .A(n678), .Q(n167) );
  OA21X6_HV U689 ( .A1(n1108), .A2(n1107), .B1(n1320), .Q(n479) );
  BUFX12_HV U690 ( .A(n1022), .Q(n168) );
  NAND3X8_HV U691 ( .A(n1320), .B(field_in[7]), .C(n695), .Q(n1324) );
  INVX12_HV U692 ( .A(\thePAT/field_alu_b[4] ), .Q(n1174) );
  OA21X6_HV U693 ( .A1(n1008), .A2(\acc_out[0]_BAR ), .B1(n895), .Q(n169) );
  AND2X6_HV U694 ( .A(n899), .B(n896), .Q(n170) );
  NAND2X6_HV U695 ( .A(n594), .B(n593), .Q(n592) );
  NAND2X12_HV U696 ( .A(n173), .B(n1296), .Q(n1183) );
  NAND2X12_HV U697 ( .A(n174), .B(n175), .Q(n173) );
  NAND2X6_HV U698 ( .A(n1519), .B(n1344), .Q(n175) );
  NAND2X3_HV U699 ( .A(n559), .B(n388), .Q(n557) );
  AND2X6_HV U700 ( .A(n1277), .B(n1376), .Q(n176) );
  NOR2X6_HV U701 ( .A(n537), .B(n177), .Q(n536) );
  NAND4X6_HV U702 ( .A(n377), .B(n1193), .C(n541), .D(n178), .Q(n177) );
  AND2X6_HV U703 ( .A(n1192), .B(n1211), .Q(n178) );
  NAND2X6_HV U704 ( .A(n1041), .B(acc_out[3]), .Q(n1000) );
  AND3X8_HV U705 ( .A(n1001), .B(n1000), .C(n999), .Q(n1003) );
  NAND2X6_HV U706 ( .A(n834), .B(n833), .Q(\thePAT/n807 ) );
  OR2X8_HV U707 ( .A(n873), .B(n654), .Q(n353) );
  BUFX24_HV U708 ( .A(n984), .Q(n180) );
  NAND2X8_HV U709 ( .A(n181), .B(\thePAT/thePC/pc[0] ), .Q(
        \thePAT/add_x_22/n32 ) );
  NAND2X12_HV U710 ( .A(n648), .B(n406), .Q(n518) );
  CLKINVX4_HV U711 ( .A(n1201), .Q(n183) );
  NAND4X6_HV U712 ( .A(n193), .B(n186), .C(n189), .D(n184), .Q(\thePAT/n790 )
         );
  AOI21X6_HV U713 ( .A1(n1036), .A2(n1212), .B1(n1027), .Q(n185) );
  NAND3X6_HV U714 ( .A(n190), .B(n695), .C(n619), .Q(n189) );
  NAND2X6_HV U715 ( .A(n192), .B(n191), .Q(n190) );
  NAND3X6_HV U716 ( .A(n511), .B(n512), .C(n510), .Q(n191) );
  INVX3_HV U717 ( .A(n196), .Q(n197) );
  CLKINVX4_HV U718 ( .A(n252), .Q(n196) );
  NAND2X8_HV U719 ( .A(n481), .B(n1315), .Q(n198) );
  NAND4X6_HV U720 ( .A(n158), .B(n1306), .C(n1305), .D(n200), .Q(n199) );
  NAND2X8_HV U721 ( .A(n162), .B(field_in[4]), .Q(n1305) );
  INVX8_HV U722 ( .A(n1360), .Q(n1350) );
  NAND3X12_HV U723 ( .A(\DP_OP_108_135_5866/n52 ), .B(n684), .C(
        \DP_OP_108_135_5866/n67 ), .Q(n1368) );
  NAND2X12_HV U724 ( .A(n202), .B(n201), .Q(n1372) );
  NOR2X6_HV U725 ( .A(n684), .B(n112), .Q(n201) );
  INVX4_HV U726 ( .A(n294), .Q(n202) );
  NAND2X12_HV U727 ( .A(n696), .B(n203), .Q(n1315) );
  NOR2X8_HV U728 ( .A(n1360), .B(n1349), .Q(n203) );
  NAND2X12_HV U729 ( .A(n204), .B(n648), .Q(n678) );
  AND3X6_HV U730 ( .A(n208), .B(n979), .C(n207), .Q(n206) );
  NAND2X6_HV U731 ( .A(n527), .B(n528), .Q(n207) );
  NAND2X6_HV U732 ( .A(n1008), .B(n529), .Q(n979) );
  AOI21X6_HV U733 ( .A1(n416), .A2(n417), .B1(n1175), .Q(n208) );
  NAND2X6_HV U734 ( .A(n211), .B(n210), .Q(n209) );
  INVX8_HV U735 ( .A(n978), .Q(n211) );
  NAND2X12_HV U736 ( .A(n848), .B(\thePAT/dest_field_regd ), .Q(n218) );
  CLKINVX4_HV U737 ( .A(\thePAT/thePC/N5 ), .Q(n1440) );
  INVX6_HV U738 ( .A(\thePAT/add_x_22/n32 ), .Q(\thePAT/add_x_22/n31 ) );
  NAND2X8_HV U739 ( .A(n224), .B(n135), .Q(n223) );
  XNOR2X2_HV U740 ( .A(n226), .B(n225), .Q(n224) );
  NAND2X8_HV U741 ( .A(\thePAT/add_x_23/n69 ), .B(\thePAT/add_x_23/n58 ), .Q(
        n226) );
  NAND2X8_HV U742 ( .A(\thePAT/thePC/pcInc[1] ), .B(n139), .Q(n227) );
  BUFX24_HV U743 ( .A(n673), .Q(n228) );
  INVX3_HV U744 ( .A(\thePAT/add_x_23/n17 ), .Q(\thePAT/add_x_23/n15 ) );
  CLKINVX4_HV U745 ( .A(n660), .Q(n232) );
  CLKINVX6_HV U746 ( .A(n617), .Q(n236) );
  NAND2X6_HV U747 ( .A(\thePAT/field_alu_b[4] ), .B(field_in[4]), .Q(n1291) );
  NAND2X8_HV U748 ( .A(n1260), .B(n421), .Q(n1197) );
  AOI21X8_HV U749 ( .A1(\DP_OP_108_135_5866/n36 ), .A2(
        \DP_OP_108_135_5866/n28 ), .B1(n405), .Q(\DP_OP_108_135_5866/n1 ) );
  NAND2X6_HV U750 ( .A(n285), .B(field_out[2]), .Q(n1213) );
  XNOR2X2_HV U751 ( .A(\DP_OP_104_132_4164/n7 ), .B(n51), .Q(n239) );
  OR2X6_HV U752 ( .A(\DP_OP_108_135_5866/n67 ), .B(n1265), .Q(n1190) );
  AND3X8_HV U753 ( .A(n984), .B(n876), .C(n879), .Q(n390) );
  CLKINVX6_HV U754 ( .A(n390), .Q(n885) );
  AND3X6_HV U755 ( .A(n1262), .B(n1376), .C(n696), .Q(n1269) );
  NAND3X8_HV U756 ( .A(n1128), .B(n304), .C(n695), .Q(n545) );
  BUFX24_HV U757 ( .A(n1347), .Q(n240) );
  OAI21X4_HV U758 ( .A1(\DP_OP_108_135_5866/n1 ), .A2(\DP_OP_108_135_5866/n12 ), .B1(\DP_OP_108_135_5866/n13 ), .Q(\DP_OP_108_135_5866/n11 ) );
  CLKINVX4_HV U759 ( .A(n1309), .Q(n246) );
  AOI21X6_HV U760 ( .A1(n1189), .A2(n1274), .B1(n1260), .Q(n1194) );
  NAND4X8_HV U761 ( .A(n840), .B(n431), .C(n878), .D(n881), .Q(n430) );
  NAND2X12_HV U762 ( .A(n984), .B(n876), .Q(n840) );
  NAND2X6_HV U763 ( .A(n974), .B(n397), .Q(n866) );
  NOR2X8_HV U764 ( .A(\DP_OP_108_135_5866/n33 ), .B(\DP_OP_108_135_5866/n30 ), 
        .Q(\DP_OP_108_135_5866/n28 ) );
  NAND3X6_HV U765 ( .A(n676), .B(n970), .C(n695), .Q(n870) );
  NAND3X6_HV U766 ( .A(n1305), .B(n1129), .C(n1220), .Q(n1130) );
  NAND2X8_HV U767 ( .A(n164), .B(inputs[6]), .Q(n1351) );
  BUFX12_HV U768 ( .A(n14), .Q(n249) );
  INVX6_HV U769 ( .A(\thePAT/add_x_23/n47 ), .Q(\thePAT/add_x_23/n46 ) );
  NOR2X12_HV U770 ( .A(n1368), .B(n1265), .Q(n1115) );
  BUFX24_HV U771 ( .A(n618), .Q(n251) );
  NAND2X6_HV U772 ( .A(n1232), .B(n1346), .Q(n1207) );
  OAI21X8_HV U773 ( .A1(\DP_OP_108_135_5866/n39 ), .A2(n253), .B1(
        \DP_OP_108_135_5866/n38 ), .Q(\DP_OP_108_135_5866/n36 ) );
  NOR2X12_HV U774 ( .A(n115), .B(field_in[1]), .Q(n253) );
  NOR2X12_HV U775 ( .A(n294), .B(field_in[0]), .Q(\DP_OP_108_135_5866/n39 ) );
  NAND2X12_HV U776 ( .A(n165), .B(n1348), .Q(n254) );
  NAND4X6_HV U777 ( .A(n262), .B(n259), .C(n257), .D(n261), .Q(\thePAT/n766 )
         );
  NOR2X12_HV U778 ( .A(\thePAT/op_add_addm_regd_2 ), .B(
        \thePAT/op_sub_subm_regd_2 ), .Q(n1307) );
  NOR2X12_HV U779 ( .A(n150), .B(\thePAT/op_shl_regd ), .Q(n1137) );
  NAND2X12_HV U780 ( .A(n255), .B(n1308), .Q(n300) );
  AOI21X8_HV U781 ( .A1(n256), .A2(n517), .B1(n1225), .Q(n375) );
  NOR2X12_HV U782 ( .A(n168), .B(n926), .Q(n1225) );
  NAND3X8_HV U783 ( .A(n991), .B(n992), .C(n293), .Q(n618) );
  XNOR2X2_HV U784 ( .A(n408), .B(n1238), .Q(n260) );
  XNOR2X2_HV U785 ( .A(n410), .B(\DP_OP_108_135_5866/n4 ), .Q(n258) );
  NAND3X6_HV U786 ( .A(n260), .B(n1382), .C(n409), .Q(n259) );
  NAND4X3_HV U787 ( .A(n576), .B(n573), .C(n365), .D(n570), .Q(n261) );
  OA211X8_HV U788 ( .A1(n266), .A2(n265), .B1(n264), .C1(n263), .Q(n262) );
  INVX6_HV U789 ( .A(n1221), .Q(n265) );
  OAI22X6_HV U790 ( .A1(n240), .A2(n1265), .B1(n1368), .B2(n1308), .Q(n268) );
  CLKINVX4_HV U791 ( .A(\thePAT/thePC/N6 ), .Q(n1442) );
  NAND2X6_HV U792 ( .A(n676), .B(n1392), .Q(n904) );
  NAND2X6_HV U793 ( .A(n676), .B(n1390), .Q(n1025) );
  NAND2X12_HV U794 ( .A(n595), .B(n592), .Q(n591) );
  NAND2X12_HV U795 ( .A(n596), .B(n372), .Q(n595) );
  OR2X6_HV U796 ( .A(n617), .B(n1164), .Q(n411) );
  NAND2X6_HV U797 ( .A(n1444), .B(n1443), .Q(\thePAT/n11 ) );
  OR3X6_HV U798 ( .A(\thePAT/data_read_adr[0] ), .B(\thePAT/data_read_adr[1] ), 
        .C(n270), .Q(n280) );
  CLKINVX16_HV U799 ( .A(n280), .Q(n789) );
  OAI211X6_HV U800 ( .A1(n38), .A2(n718), .B1(n717), .C1(n716), .Q(
        \thePAT/N45 ) );
  NAND2X3_HV U801 ( .A(n679), .B(n1390), .Q(n520) );
  NAND2X6_HV U802 ( .A(n1010), .B(n609), .Q(n608) );
  AND3X8_HV U803 ( .A(n1050), .B(n1051), .C(n1049), .Q(n1083) );
  CLKINVX8_HV U804 ( .A(\thePAT/data_read_adr[2] ), .Q(n702) );
  AND2X8_HV U805 ( .A(n992), .B(n991), .Q(n369) );
  NAND2X6_HV U806 ( .A(n397), .B(n1053), .Q(n957) );
  INVX32_HV U807 ( .A(n136), .Q(n1376) );
  CLKINVX4_HV U808 ( .A(n676), .Q(n897) );
  BUFX32_HV U809 ( .A(n791), .Q(n669) );
  NAND3X3_HV U810 ( .A(n930), .B(n1390), .C(n1040), .Q(n860) );
  CLKINVX4_HV U811 ( .A(n301), .Q(n583) );
  AND2X6_HV U812 ( .A(n301), .B(n948), .Q(n876) );
  NAND2X6_HV U813 ( .A(n530), .B(n249), .Q(n999) );
  NAND2X3_HV U814 ( .A(n1515), .B(n1489), .Q(\iBuffer/N44 ) );
  NAND2X12_HV U815 ( .A(n686), .B(n338), .Q(n878) );
  NAND2X6_HV U816 ( .A(n676), .B(acc_out[5]), .Q(n933) );
  NAND2X6_HV U817 ( .A(n1130), .B(n1277), .Q(n544) );
  NAND2X3_HV U818 ( .A(n837), .B(buf_fieldp[7]), .Q(n836) );
  OR2X8_HV U819 ( .A(n459), .B(n368), .Q(n837) );
  AND2X4_HV U820 ( .A(n634), .B(\thePAT/dest_acc_regd ), .Q(n366) );
  NAND2X3_HV U821 ( .A(\DP_OP_104_132_4164/n46 ), .B(\DP_OP_104_132_4164/n32 ), 
        .Q(\DP_OP_104_132_4164/n6 ) );
  NOR2X12_HV U822 ( .A(n1415), .B(n1417), .Q(n1414) );
  NAND4X4_HV U823 ( .A(n346), .B(n622), .C(\thePAT/n64 ), .D(n1095), .Q(n845)
         );
  OAI21X6_HV U824 ( .A1(\thePAT/add_x_23/n55 ), .A2(n623), .B1(n626), .Q(
        \thePAT/add_x_23/n52 ) );
  NOR2X4_HV U825 ( .A(n1269), .B(n1268), .Q(n1281) );
  NAND2X6_HV U826 ( .A(n1004), .B(n651), .Q(n937) );
  AND2X6_HV U827 ( .A(n1005), .B(n1004), .Q(n372) );
  AND2X6_HV U828 ( .A(n936), .B(n935), .Q(n1004) );
  NAND2X6_HV U829 ( .A(n526), .B(n1433), .Q(\thePAT/thePC/N21 ) );
  NAND2X6_HV U830 ( .A(\thePAT/thePC/pcInc[7] ), .B(n139), .Q(n1433) );
  AOI21X6_HV U831 ( .A1(n1376), .A2(n1103), .B1(n1102), .Q(n1122) );
  BUFX32_HV U832 ( .A(n518), .Q(n674) );
  CLKINVX6_HV U833 ( .A(n1088), .Q(n1015) );
  NOR3X6_HV U834 ( .A(n650), .B(n674), .C(n1109), .Q(n1014) );
  INVX24_HV U835 ( .A(\DP_OP_108_135_5866/n52 ), .Q(n273) );
  NOR2X6_HV U836 ( .A(n459), .B(n826), .Q(n1246) );
  NAND2X8_HV U837 ( .A(n654), .B(n874), .Q(n568) );
  AND3X8_HV U838 ( .A(n1063), .B(n1062), .C(n1061), .Q(n1082) );
  MUX2X6_HV U839 ( .A(n126), .B(n827), .S(n1246), .Q(\thePAT/n810 ) );
  NAND2X12_HV U840 ( .A(n485), .B(n482), .Q(n852) );
  NAND2X6_HV U841 ( .A(n403), .B(n1054), .Q(n1059) );
  NAND3X12_HV U842 ( .A(n871), .B(n654), .C(n483), .Q(n485) );
  NAND3X8_HV U843 ( .A(n701), .B(n422), .C(n313), .Q(n425) );
  XNOR2X2_HV U844 ( .A(\thePAT/thePC/pc[8] ), .B(\thePAT/add_x_22/n4 ), .Q(
        \thePAT/thePC/pcInc[8] ) );
  NAND2X6_HV U845 ( .A(n159), .B(acc_out[0]), .Q(n274) );
  INVX24_HV U846 ( .A(\thePAT/n74 ), .Q(acc_out[2]) );
  NAND2X6_HV U847 ( .A(n247), .B(\thePAT/n74 ), .Q(n888) );
  OA211X4_HV U848 ( .A1(\thePAT/n74 ), .A2(n1042), .B1(n931), .C1(n975), .Q(
        n932) );
  NAND2X6_HV U849 ( .A(\thePAT/data_read_adr[1] ), .B(
        \thePAT/data_read_adr[2] ), .Q(n705) );
  NAND2X3_HV U850 ( .A(n832), .B(\thePAT/immediate_regd[0] ), .Q(n834) );
  CLKBUFX2_HV U851 ( .A(n820), .Q(n275) );
  OR2X8_HV U852 ( .A(n916), .B(acc_out[0]), .Q(n988) );
  NAND2X6_HV U853 ( .A(n870), .B(n869), .Q(n461) );
  NAND2X6_HV U854 ( .A(n1013), .B(n284), .Q(n1109) );
  NOR2X12_HV U855 ( .A(n1110), .B(n1109), .Q(n1111) );
  NAND2X6_HV U856 ( .A(n879), .B(n880), .Q(n841) );
  NAND2X1_HV U857 ( .A(n624), .B(\thePAT/add_x_23/n51 ), .Q(
        \thePAT/add_x_23/n7 ) );
  NAND2X12_HV U858 ( .A(n958), .B(n695), .Q(n974) );
  NOR2X6_HV U859 ( .A(n1052), .B(n1029), .Q(n960) );
  OR3X2_HV U860 ( .A(n1229), .B(field_in[3]), .C(n115), .Q(n1230) );
  CLKINVX8_HV U861 ( .A(n633), .Q(n634) );
  NOR2X6_HV U862 ( .A(n1210), .B(n1194), .Q(n535) );
  AND2X8_HV U863 ( .A(n948), .B(n878), .Q(n389) );
  NOR2X6_HV U864 ( .A(n389), .B(n583), .Q(n577) );
  CLKBUFX32_HV U865 ( .A(n517), .Q(n695) );
  NAND2X12_HV U866 ( .A(n1320), .B(n695), .Q(n1364) );
  NOR2X6_HV U867 ( .A(n607), .B(n606), .Q(n605) );
  CLKINVX4_HV U868 ( .A(n1018), .Q(n607) );
  NAND2X3_HV U869 ( .A(n638), .B(n197), .Q(n540) );
  OA21X6_HV U870 ( .A1(field_in[2]), .A2(n251), .B1(n1212), .Q(n1192) );
  NAND2X3_HV U871 ( .A(n678), .B(\thePAT/acc_alu_b[5] ), .Q(n943) );
  NAND2X6_HV U872 ( .A(n702), .B(\thePAT/data_read_adr[0] ), .Q(n703) );
  NOR2X12_HV U873 ( .A(n704), .B(n298), .Q(n668) );
  NAND2X12_HV U874 ( .A(n702), .B(n402), .Q(n704) );
  AOI31X8_HV U875 ( .A1(n536), .A2(n535), .A3(n534), .B1(n532), .Q(
        \thePAT/n769 ) );
  NAND2X3_HV U876 ( .A(\thePAT/thePC/pcInc[8] ), .B(n139), .Q(n1434) );
  NAND2X6_HV U877 ( .A(n1448), .B(n1447), .Q(\thePAT/n7 ) );
  NAND3X6_HV U878 ( .A(n1422), .B(n325), .C(n87), .Q(n806) );
  NAND2X12_HV U879 ( .A(n165), .B(field_in[6]), .Q(n1200) );
  NAND2X3_HV U880 ( .A(n458), .B(acc_out[5]), .Q(n1384) );
  OAI211X6_HV U881 ( .A1(n752), .A2(n666), .B1(n751), .C1(n418), .Q(
        \thePAT/N42 ) );
  OR2X6_HV U882 ( .A(n601), .B(n1075), .Q(n600) );
  OAI21X8_HV U883 ( .A1(n271), .A2(n394), .B1(n304), .Q(n546) );
  OR2X6_HV U884 ( .A(n697), .B(field_in[0]), .Q(n1116) );
  INVX32_HV U885 ( .A(n697), .Q(\DP_OP_108_135_5866/n67 ) );
  NAND2X3_HV U886 ( .A(n1170), .B(n684), .Q(n1173) );
  NOR3X12_HV U887 ( .A(n803), .B(n802), .C(n801), .Q(n1452) );
  NAND2X3_HV U888 ( .A(n110), .B(\DP_OP_108_135_5866/n31 ), .Q(
        \DP_OP_108_135_5866/n6 ) );
  AND3X3_HV U889 ( .A(\thePAT/op_sub_subm_regd ), .B(\thePAT/n64 ), .C(n1095), 
        .Q(n844) );
  NAND2X12_HV U890 ( .A(n1135), .B(n1134), .Q(n1311) );
  CLKINVX6_HV U891 ( .A(n1134), .Q(n1089) );
  NOR2X12_HV U892 ( .A(n1097), .B(n1096), .Q(n1382) );
  AOI21X6_HV U893 ( .A1(n1377), .A2(n1293), .B1(n388), .Q(n1294) );
  NAND2X3_HV U894 ( .A(n696), .B(n102), .Q(n851) );
  OAI21X8_HV U895 ( .A1(n555), .A2(n1205), .B1(n1145), .Q(n551) );
  AOI21X6_HV U896 ( .A1(n1379), .A2(n1286), .B1(n1236), .Q(n408) );
  NAND2X6_HV U897 ( .A(n1379), .B(n1289), .Q(n1298) );
  NAND3X8_HV U898 ( .A(n848), .B(n485), .C(n864), .Q(n484) );
  NAND2X6_HV U899 ( .A(n848), .B(n864), .Q(n843) );
  OR2X6_HV U900 ( .A(n683), .B(field_in[4]), .Q(n1156) );
  OAI21X8_HV U901 ( .A1(\DP_OP_108_135_5866/n23 ), .A2(
        \DP_OP_108_135_5866/n27 ), .B1(\DP_OP_108_135_5866/n24 ), .Q(
        \DP_OP_108_135_5866/n22 ) );
  NOR2X6_HV U902 ( .A(n663), .B(field_in[5]), .Q(\DP_OP_108_135_5866/n23 ) );
  NOR2X12_HV U903 ( .A(n642), .B(n1040), .Q(n1032) );
  NAND2X3_HV U904 ( .A(n676), .B(n1239), .Q(n506) );
  NAND2X6_HV U905 ( .A(n1041), .B(acc_out[5]), .Q(n1033) );
  NAND2X8_HV U906 ( .A(n1307), .B(n622), .Q(n1358) );
  NAND3X12_HV U907 ( .A(n992), .B(n991), .C(n1095), .Q(n1360) );
  OR2X8_HV U908 ( .A(\thePAT/thePC/N8 ), .B(n279), .Q(\thePAT/n10 ) );
  OAI211X6_HV U909 ( .A1(n1038), .A2(n1039), .B1(n1037), .C1(n675), .Q(n1050)
         );
  NAND2X6_HV U910 ( .A(n605), .B(n608), .Q(n604) );
  NAND3X6_HV U911 ( .A(n915), .B(n516), .C(n914), .Q(\thePAT/n794 ) );
  NAND3X6_HV U912 ( .A(n1080), .B(n1079), .C(n1078), .Q(n1081) );
  OR2X6_HV U913 ( .A(n1042), .B(\acc_out[1]_BAR ), .Q(n355) );
  OR2X6_HV U914 ( .A(n278), .B(acc_out[2]), .Q(n373) );
  NAND2X3_HV U915 ( .A(n458), .B(n1392), .Q(n1393) );
  CLKINVX12_HV U916 ( .A(n457), .Q(n458) );
  NAND2X6_HV U917 ( .A(n675), .B(n1263), .Q(n895) );
  NAND2X6_HV U918 ( .A(n1119), .B(n675), .Q(n1057) );
  AND2X6_HV U919 ( .A(n675), .B(n696), .Q(n981) );
  OAI211X6_HV U920 ( .A1(n781), .A2(n666), .B1(n780), .C1(n424), .Q(
        \thePAT/N39 ) );
  OR2X8_HV U921 ( .A(n165), .B(field_in[1]), .Q(n647) );
  OR2X6_HV U922 ( .A(n1201), .B(n1218), .Q(n1366) );
  NAND3X6_HV U923 ( .A(n560), .B(n1356), .C(n1376), .Q(n492) );
  OAI211X6_HV U924 ( .A1(n840), .A2(n431), .B1(n430), .C1(n428), .Q(n440) );
  BUFX32_HV U925 ( .A(n787), .Q(n667) );
  CLKINVX4_HV U926 ( .A(n843), .Q(n482) );
  NAND2X12_HV U927 ( .A(n619), .B(n695), .Q(n1077) );
  AND3X6_HV U928 ( .A(n1297), .B(n1296), .C(n1295), .Q(n1304) );
  NAND2X6_HV U929 ( .A(n617), .B(field_out[1]), .Q(n398) );
  NAND2X12_HV U930 ( .A(n399), .B(n828), .Q(n617) );
  NAND4X6_HV U931 ( .A(n471), .B(n470), .C(n361), .D(n886), .Q(n469) );
  NOR2X12_HV U932 ( .A(\thePAT/op_sub_subm_regd ), .B(n293), .Q(n1016) );
  NAND2X6_HV U933 ( .A(\thePAT/acc_alu_b[2] ), .B(n1572), .Q(
        \DP_OP_104_132_4164/n35 ) );
  CLKINVX2_HV U934 ( .A(n251), .Q(n417) );
  NAND2X3_HV U935 ( .A(\DP_OP_108_135_5866/n42 ), .B(\DP_OP_108_135_5866/n24 ), 
        .Q(\DP_OP_108_135_5866/n4 ) );
  NAND2X3_HV U936 ( .A(n663), .B(field_in[5]), .Q(\DP_OP_108_135_5866/n24 ) );
  NAND4X6_HV U937 ( .A(n727), .B(n726), .C(n725), .D(n724), .Q(n728) );
  OA211X4_HV U938 ( .A1(n893), .A2(n892), .B1(n675), .C1(n1392), .Q(n902) );
  XNOR2X2_HV U939 ( .A(n656), .B(n282), .Q(\thePAT/thePC/pcInc[3] ) );
  BUFX32_HV U940 ( .A(n790), .Q(n670) );
  INVX24_HV U941 ( .A(\thePAT/condition_regd[1] ), .Q(n871) );
  OA21X3_HV U942 ( .A1(n1008), .A2(\thePAT/n74 ), .B1(n961), .Q(n965) );
  NOR2X12_HV U943 ( .A(n397), .B(n1027), .Q(n954) );
  NAND2X12_HV U944 ( .A(n399), .B(n828), .Q(n285) );
  NAND3X12_HV U945 ( .A(n871), .B(n345), .C(\thePAT/condition_regd[0] ), .Q(
        n828) );
  NAND2X6_HV U946 ( .A(n468), .B(n357), .Q(n467) );
  AOI21X8_HV U947 ( .A1(n600), .A2(n598), .B1(n1007), .Q(n597) );
  BUFX24_HV U948 ( .A(n668), .Q(n401) );
  NAND4X6_HV U949 ( .A(n735), .B(n734), .C(n733), .D(n732), .Q(n736) );
  NAND2X3_HV U950 ( .A(n1273), .B(field_in[1]), .Q(n1129) );
  CLKINVX6_HV U951 ( .A(n1323), .Q(n1273) );
  NAND2X3_HV U952 ( .A(n1339), .B(\thePAT/field_value[0] ), .Q(n1249) );
  NAND2X3_HV U953 ( .A(n1339), .B(\thePAT/field_value[4] ), .Q(n1141) );
  NAND2X3_HV U954 ( .A(n1339), .B(\thePAT/field_value[2] ), .Q(n1185) );
  NAND2X3_HV U955 ( .A(n1339), .B(\thePAT/field_value[5] ), .Q(n1216) );
  NAND2X3_HV U956 ( .A(n1339), .B(\thePAT/field_value[6] ), .Q(n1342) );
  NAND2X3_HV U957 ( .A(n1339), .B(\thePAT/field_value[1] ), .Q(n1124) );
  NAND2X3_HV U958 ( .A(n1339), .B(\thePAT/field_value[3] ), .Q(n1085) );
  NAND2X3_HV U959 ( .A(\thePAT/pc_immediate[7] ), .B(\thePAT/thePC/pc[7] ), 
        .Q(\thePAT/add_x_23/n24 ) );
  NAND2X6_HV U960 ( .A(n526), .B(n288), .Q(\thePAT/n8 ) );
  NAND2X6_HV U961 ( .A(n1173), .B(n1172), .Q(n1270) );
  NAND2X3_HV U962 ( .A(n137), .B(acc_out[7]), .Q(n1285) );
  NAND2X3_HV U963 ( .A(n137), .B(n249), .Q(n1142) );
  NAND2X3_HV U964 ( .A(n137), .B(acc_out[5]), .Q(n1217) );
  NAND2X6_HV U965 ( .A(n971), .B(n1392), .Q(n548) );
  OAI21X8_HV U966 ( .A1(\thePAT/add_x_23/n50 ), .A2(\thePAT/add_x_23/n54 ), 
        .B1(\thePAT/add_x_23/n51 ), .Q(\thePAT/add_x_23/n49 ) );
  NOR2X6_HV U967 ( .A(n1150), .B(n1149), .Q(n1155) );
  OAI21X6_HV U968 ( .A1(n85), .A2(n1200), .B1(n1199), .Q(n1357) );
  NAND4X6_HV U969 ( .A(n714), .B(n711), .C(n712), .D(n713), .Q(n715) );
  NAND2X6_HV U970 ( .A(n466), .B(n357), .Q(n465) );
  NAND2X12_HV U971 ( .A(n115), .B(field_in[1]), .Q(\DP_OP_108_135_5866/n38 )
         );
  CLKINVX2_HV U972 ( .A(n1006), .Q(n594) );
  NAND2X6_HV U973 ( .A(n681), .B(n318), .Q(n995) );
  BUFX24_HV U974 ( .A(n793), .Q(n671) );
  CLKINVX12_HV U975 ( .A(\thePAT/op_or_regd ), .Q(n991) );
  NOR2X12_HV U976 ( .A(n136), .B(n674), .Q(n1296) );
  NAND2X3_HV U977 ( .A(n676), .B(n249), .Q(n973) );
  BUFX32_HV U978 ( .A(n1032), .Q(n676) );
  NAND2X6_HV U979 ( .A(\thePAT/opcode_i3[3] ), .B(\thePAT/opcode_i3[1] ), .Q(
        n808) );
  NAND2X8_HV U980 ( .A(n1422), .B(n644), .Q(n813) );
  NAND2X12_HV U981 ( .A(n294), .B(n165), .Q(n1370) );
  NAND2X6_HV U982 ( .A(n165), .B(\DP_OP_108_135_5866/n67 ), .Q(n1171) );
  NAND2X6_HV U983 ( .A(n1011), .B(n1239), .Q(n940) );
  OAI21X8_HV U984 ( .A1(\thePAT/add_x_23/n47 ), .A2(\thePAT/add_x_23/n19 ), 
        .B1(\thePAT/add_x_23/n20 ), .Q(\thePAT/add_x_23/n18 ) );
  AOI21X6_HV U985 ( .A1(n1267), .A2(n1266), .B1(n493), .Q(n1268) );
  NAND2X12_HV U986 ( .A(n164), .B(inputs[2]), .Q(n1212) );
  AND3X6_HV U987 ( .A(n1137), .B(\thePAT/n64 ), .C(n284), .Q(n514) );
  NAND2X6_HV U988 ( .A(\thePAT/n57 ), .B(\thePAT/op_shlo_regd ), .Q(n936) );
  NAND2X6_HV U989 ( .A(n524), .B(\DP_OP_104_132_4164/n21 ), .Q(n434) );
  NOR2X12_HV U990 ( .A(\thePAT/thePC/pc[6] ), .B(\thePAT/pc_immediate[6] ), 
        .Q(\thePAT/add_x_23/n28 ) );
  NAND2X3_HV U991 ( .A(n286), .B(field_out[4]), .Q(n1163) );
  INVX1_HV U992 ( .A(\DP_OP_108_135_5866/n23 ), .Q(\DP_OP_108_135_5866/n42 )
         );
  NAND4X6_HV U993 ( .A(n469), .B(n362), .C(n467), .D(n465), .Q(\thePAT/n796 )
         );
  NAND2X3_HV U994 ( .A(n137), .B(acc_out[2]), .Q(n1186) );
  NAND2X3_HV U995 ( .A(n137), .B(acc_out[3]), .Q(n1086) );
  NAND2X3_HV U996 ( .A(n137), .B(n108), .Q(n1343) );
  NAND2X3_HV U997 ( .A(n137), .B(n1390), .Q(n1125) );
  NAND2X3_HV U998 ( .A(n137), .B(n1392), .Q(n1250) );
  BUFX24_HV U999 ( .A(n1352), .Q(n679) );
  NAND2X6_HV U1000 ( .A(n543), .B(n304), .Q(n542) );
  NAND3X12_HV U1001 ( .A(n420), .B(n1105), .C(n369), .Q(n421) );
  AND2X6_HV U1002 ( .A(n1106), .B(n1104), .Q(n420) );
  OA21X6_HV U1003 ( .A1(n1324), .A2(n1323), .B1(n1322), .Q(n1333) );
  OAI21X8_HV U1004 ( .A1(n1270), .A2(n1179), .B1(n1178), .Q(n1180) );
  NOR2X8_HV U1005 ( .A(\thePAT/add_x_22/n23 ), .B(\thePAT/add_x_22/n10 ), .Q(
        \thePAT/add_x_22/n9 ) );
  CLKINVX8_HV U1006 ( .A(\thePAT/add_x_22/n24 ), .Q(\thePAT/add_x_22/n23 ) );
  NAND2X3_HV U1007 ( .A(\thePAT/add_x_22/n15 ), .B(\thePAT/thePC/pc[6] ), .Q(
        \thePAT/add_x_22/n10 ) );
  NOR2X12_HV U1008 ( .A(n427), .B(\thePAT/add_x_22/n32 ), .Q(
        \thePAT/add_x_22/n24 ) );
  NAND2X6_HV U1009 ( .A(n322), .B(field_in[4]), .Q(\DP_OP_108_135_5866/n27 )
         );
  AND2X6_HV U1010 ( .A(n1382), .B(n1209), .Q(n1210) );
  NOR2X6_HV U1011 ( .A(n704), .B(\thePAT/data_read_adr[1] ), .Q(n790) );
  AOI21X8_HV U1012 ( .A1(\thePAT/add_x_23/n34 ), .A2(\thePAT/add_x_23/n21 ), 
        .B1(\thePAT/add_x_23/n22 ), .Q(\thePAT/add_x_23/n20 ) );
  OAI21X8_HV U1013 ( .A1(\thePAT/add_x_23/n39 ), .A2(\thePAT/add_x_23/n45 ), 
        .B1(\thePAT/add_x_23/n40 ), .Q(\thePAT/add_x_23/n34 ) );
  NOR2X12_HV U1014 ( .A(n681), .B(acc_out[1]), .Q(\DP_OP_104_132_4164/n38 ) );
  CLKINVX10_HV U1015 ( .A(\thePAT/z1 ), .Q(n872) );
  NOR2X12_HV U1016 ( .A(n1088), .B(n937), .Q(n938) );
  INVX24_HV U1017 ( .A(n518), .Q(n517) );
  OAI211X6_HV U1018 ( .A1(n770), .A2(n799), .B1(n445), .C1(n442), .Q(
        \thePAT/N40 ) );
  OAI21X8_HV U1019 ( .A1(n252), .A2(\DP_OP_108_135_5866/n30 ), .B1(
        \DP_OP_108_135_5866/n31 ), .Q(n405) );
  NAND2X6_HV U1020 ( .A(n525), .B(n523), .Q(n522) );
  NAND2X6_HV U1021 ( .A(n643), .B(\thePAT/opcode_i8[2] ), .Q(n821) );
  NAND3X6_HV U1022 ( .A(n731), .B(n730), .C(n729), .Q(\thePAT/N44 ) );
  NOR2X8_HV U1023 ( .A(n1358), .B(n1360), .Q(n1325) );
  NAND4X6_HV U1024 ( .A(n435), .B(n432), .C(n437), .D(n439), .Q(\thePAT/n782 )
         );
  OAI21X8_HV U1025 ( .A1(n479), .A2(n474), .B1(n1121), .Q(n473) );
  NAND2X6_HV U1026 ( .A(\DP_OP_108_135_5866/n52 ), .B(n1308), .Q(n1232) );
  NAND2X6_HV U1027 ( .A(n1092), .B(n1346), .Q(n1094) );
  NAND2X6_HV U1028 ( .A(n1429), .B(n1428), .Q(\thePAT/thePC/N6 ) );
  CLKINVX8_HV U1029 ( .A(\thePAT/op_not_regd ), .Q(n292) );
  INVX24_HV U1030 ( .A(n292), .Q(n293) );
  NAND2X6_HV U1031 ( .A(\thePAT/thePC/pc[6] ), .B(\thePAT/pc_immediate[6] ), 
        .Q(\thePAT/add_x_23/n31 ) );
  OA211X8_HV U1032 ( .A1(n498), .A2(n493), .B1(n492), .C1(n384), .Q(n491) );
  NOR2X6_HV U1033 ( .A(n393), .B(n486), .Q(n498) );
  NOR2X6_HV U1034 ( .A(\thePAT/add_x_23/n23 ), .B(\thePAT/add_x_23/n28 ), .Q(
        \thePAT/add_x_23/n21 ) );
  CLKINVX12_HV U1035 ( .A(n293), .Q(n1095) );
  NAND4X6_HV U1036 ( .A(n939), .B(n938), .C(n993), .D(n994), .Q(n942) );
  NAND2X6_HV U1037 ( .A(n988), .B(n987), .Q(n1067) );
  NAND2X3_HV U1038 ( .A(n799), .B(n1524), .Q(n751) );
  NOR2X12_HV U1039 ( .A(n1088), .B(n845), .Q(n958) );
  NOR2X6_HV U1040 ( .A(n703), .B(\thePAT/data_read_adr[1] ), .Q(n787) );
  NAND3X6_HV U1041 ( .A(n378), .B(n1223), .C(n1320), .Q(n611) );
  NAND2X3_HV U1042 ( .A(n147), .B(acc_out[7]), .Q(n1302) );
  BUFX24_HV U1043 ( .A(n792), .Q(n672) );
  NAND4X6_HV U1044 ( .A(n414), .B(n986), .C(n356), .D(n412), .Q(\thePAT/n786 )
         );
  NOR2X6_HV U1045 ( .A(\thePAT/add_x_22/n23 ), .B(\thePAT/add_x_22/n14 ), .Q(
        \thePAT/add_x_22/n13 ) );
  NAND2X6_HV U1046 ( .A(n640), .B(n79), .Q(n427) );
  INVX24_HV U1047 ( .A(n852), .Q(n619) );
  NAND2X12_HV U1048 ( .A(n550), .B(n1367), .Q(n1143) );
  NAND2X12_HV U1049 ( .A(n379), .B(n1008), .Q(n1060) );
  NAND2X6_HV U1050 ( .A(\thePAT/add_x_22/n5 ), .B(\thePAT/add_x_22/n24 ), .Q(
        \thePAT/add_x_22/n4 ) );
  NAND2X12_HV U1051 ( .A(n682), .B(acc_out[0]), .Q(\DP_OP_104_132_4164/n41 )
         );
  CLKINVX8_HV U1052 ( .A(n1075), .Q(n990) );
  NOR2X6_HV U1053 ( .A(n1077), .B(n1075), .Q(n949) );
  NAND2X12_HV U1054 ( .A(n1015), .B(n844), .Q(n1075) );
  OAI211X6_HV U1055 ( .A1(n847), .A2(n974), .B1(n1351), .C1(n846), .Q(n849) );
  OR2X6_HV U1056 ( .A(n1309), .B(n1367), .Q(n1313) );
  NAND2X6_HV U1057 ( .A(n615), .B(n135), .Q(n614) );
  NAND3X12_HV U1058 ( .A(n842), .B(n871), .C(n872), .Q(n848) );
  CLKINVX4_HV U1059 ( .A(n1138), .Q(n1136) );
  AND3X4_HV U1060 ( .A(n1311), .B(n696), .C(n1138), .Q(n392) );
  IMUX2X1_HV U1061 ( .A(field_in[6]), .B(field_in[7]), .S(
        \DP_OP_108_135_5866/n67 ), .Q(n1170) );
  NAND2X6_HV U1062 ( .A(n859), .B(n858), .Q(n861) );
  AOI21X8_HV U1063 ( .A1(\thePAT/add_x_23/n18 ), .A2(n302), .B1(
        \thePAT/add_x_23/n15 ), .Q(n556) );
  MUX2X6_HV U1064 ( .A(\thePAT/z1 ), .B(n126), .S(n654), .Q(n824) );
  NAND2X6_HV U1065 ( .A(\thePAT/thePC/pc[4] ), .B(\thePAT/pc_immediate[4] ), 
        .Q(\thePAT/add_x_23/n45 ) );
  NAND2X3_HV U1066 ( .A(n286), .B(field_out[5]), .Q(n1234) );
  OAI31X3_HV U1067 ( .A1(n338), .A2(n677), .A3(n1239), .B1(n943), .Q(n944) );
  OA21X6_HV U1068 ( .A1(n677), .A2(n312), .B1(acc_out[7]), .Q(n869) );
  BUFX24_HV U1069 ( .A(n1354), .Q(n677) );
  NAND2X3_HV U1070 ( .A(n1055), .B(\thePAT/field_value[2] ), .Q(n961) );
  BUFX24_HV U1071 ( .A(n641), .Q(n294) );
  NOR2X12_HV U1072 ( .A(n106), .B(n916), .Q(n930) );
  AND3X6_HV U1073 ( .A(n696), .B(n241), .C(n1224), .Q(n378) );
  NAND2X6_HV U1074 ( .A(n612), .B(n1200), .Q(n1224) );
  NAND2X12_HV U1075 ( .A(n164), .B(inputs[3]), .Q(n1112) );
  NOR2X12_HV U1076 ( .A(n924), .B(n505), .Q(n504) );
  NOR2X12_HV U1077 ( .A(\thePAT/source_field_regd ), .B(n141), .Q(n864) );
  NAND2X6_HV U1078 ( .A(\thePAT/thePC/pc[2] ), .B(\thePAT/pc_immediate[2] ), 
        .Q(\thePAT/add_x_23/n54 ) );
  NAND2X6_HV U1079 ( .A(n664), .B(field_in[3]), .Q(\DP_OP_108_135_5866/n31 )
         );
  NAND2X12_HV U1080 ( .A(n1111), .B(n1350), .Q(n1260) );
  AND3X8_HV U1081 ( .A(n1214), .B(n1196), .C(n1213), .Q(n377) );
  NAND2X3_HV U1082 ( .A(n1195), .B(field_in[2]), .Q(n1196) );
  OR2X6_HV U1083 ( .A(\thePAT/field_alu_b[0] ), .B(\thePAT/field_alu_b[2] ), 
        .Q(n1229) );
  AO22X6_HV U1084 ( .A1(n1517), .A2(n1344), .B1(n1382), .B2(n1127), .Q(n1128)
         );
  AO22X6_HV U1085 ( .A1(n1253), .A2(n1382), .B1(n1344), .B2(n1516), .Q(n1257)
         );
  NOR2X12_HV U1086 ( .A(n1088), .B(n1087), .Q(n1344) );
  NAND2X6_HV U1087 ( .A(n676), .B(acc_out[7]), .Q(n865) );
  NAND2X3_HV U1088 ( .A(n240), .B(n1310), .Q(n1149) );
  NAND2X3_HV U1089 ( .A(n695), .B(n1310), .Q(n1228) );
  NAND2X6_HV U1090 ( .A(n908), .B(n114), .Q(n909) );
  MUX2X3_HV U1091 ( .A(n665), .B(n318), .S(n104), .Q(n908) );
  NAND2X8_HV U1092 ( .A(\thePAT/thePC/pc[1] ), .B(\thePAT/pc_immediate[1] ), 
        .Q(\thePAT/add_x_23/n58 ) );
  AOI22X6_HV U1093 ( .A1(n1098), .A2(n149), .B1(n1518), .B2(n133), .Q(n480) );
  NOR2X12_HV U1094 ( .A(\thePAT/pc_immediate[3] ), .B(\thePAT/thePC/pc[3] ), 
        .Q(\thePAT/add_x_23/n50 ) );
  NAND2X6_HV U1095 ( .A(\thePAT/thePC/pc[3] ), .B(\thePAT/pc_immediate[3] ), 
        .Q(\thePAT/add_x_23/n51 ) );
  NAND2X3_HV U1096 ( .A(acc_out[6]), .B(\thePAT/acc_alu_b[6] ), .Q(
        \DP_OP_104_132_4164/n18 ) );
  AOI21X6_HV U1097 ( .A1(n147), .A2(n1392), .B1(n364), .Q(n1254) );
  AND2X8_HV U1098 ( .A(\DP_OP_108_135_5866/n67 ), .B(field_in[0]), .Q(n1251)
         );
  NOR2X6_HV U1099 ( .A(n802), .B(n698), .Q(n700) );
  CLKINVX2_HV U1100 ( .A(\DP_OP_104_132_4164/n31 ), .Q(
        \DP_OP_104_132_4164/n46 ) );
  NOR2X6_HV U1101 ( .A(\DP_OP_104_132_4164/n34 ), .B(\DP_OP_104_132_4164/n31 ), 
        .Q(\DP_OP_104_132_4164/n29 ) );
  NAND3X12_HV U1102 ( .A(n502), .B(n310), .C(n500), .Q(n984) );
  AO21X6_HV U1103 ( .A1(n1176), .A2(field_in[4]), .B1(n1175), .Q(n1177) );
  NAND4X6_HV U1104 ( .A(n477), .B(n476), .C(n1112), .D(n475), .Q(n474) );
  NAND3X6_HV U1105 ( .A(n1183), .B(n1182), .C(n1181), .Q(\thePAT/n767 ) );
  OAI211X6_HV U1106 ( .A1(n798), .A2(n38), .B1(n449), .C1(n452), .Q(
        \thePAT/N38 ) );
  NAND4X4_HV U1107 ( .A(n1326), .B(n696), .C(n273), .D(n1325), .Q(n1332) );
  CLKINVX4_HV U1108 ( .A(n1112), .Q(n1119) );
  NAND3X12_HV U1109 ( .A(n553), .B(n552), .C(n1144), .Q(n1379) );
  NOR2X8_HV U1110 ( .A(n829), .B(n654), .Q(n655) );
  NOR2X6_HV U1111 ( .A(n1040), .B(n674), .Q(n939) );
  INVX24_HV U1112 ( .A(\thePAT/n46 ), .Q(n1040) );
  NAND2X3_HV U1113 ( .A(\DP_OP_108_135_5866/n67 ), .B(n684), .Q(n1231) );
  CLKINVX6_HV U1114 ( .A(n515), .Q(n528) );
  NAND2X6_HV U1115 ( .A(n684), .B(n1327), .Q(n613) );
  CLKINVX2_HV U1116 ( .A(\DP_OP_108_135_5866/n17 ), .Q(
        \DP_OP_108_135_5866/n15 ) );
  NAND2X3_HV U1117 ( .A(n659), .B(field_in[6]), .Q(\DP_OP_108_135_5866/n17 )
         );
  CLKINVX12_HV U1118 ( .A(n421), .Q(n1320) );
  NAND2X3_HV U1119 ( .A(n1016), .B(n995), .Q(n941) );
  NAND2X3_HV U1120 ( .A(n128), .B(n1311), .Q(n1312) );
  OA21X6_HV U1121 ( .A1(n1160), .A2(field_in[2]), .B1(n1159), .Q(n1161) );
  NAND2X3_HV U1122 ( .A(n248), .B(n1190), .Q(n1159) );
  NOR2X12_HV U1123 ( .A(n662), .B(\thePAT/n1 ), .Q(n874) );
  OAI21X8_HV U1124 ( .A1(n591), .A2(n597), .B1(n911), .Q(n590) );
  NAND2X3_HV U1125 ( .A(n1368), .B(n241), .Q(n1187) );
  NAND2X3_HV U1126 ( .A(n1040), .B(n995), .Q(n996) );
  OAI21X8_HV U1127 ( .A1(\DP_OP_104_132_4164/n38 ), .A2(
        \DP_OP_104_132_4164/n41 ), .B1(\DP_OP_104_132_4164/n39 ), .Q(
        \DP_OP_104_132_4164/n37 ) );
  INVX24_HV U1128 ( .A(n675), .Q(n1027) );
  CLKINVX4_HV U1129 ( .A(\thePAT/add_x_23/n34 ), .Q(\thePAT/add_x_23/n36 ) );
  NAND4X6_HV U1130 ( .A(n489), .B(n491), .C(n488), .D(n487), .Q(\thePAT/n765 )
         );
  NAND2X3_HV U1131 ( .A(n697), .B(n684), .Q(n1160) );
  NOR2X12_HV U1132 ( .A(n1287), .B(n1292), .Q(n1378) );
  NAND2X12_HV U1133 ( .A(n1174), .B(n1218), .Q(n1286) );
  AND2X6_HV U1134 ( .A(n1069), .B(n1064), .Q(n340) );
  NAND2X3_HV U1135 ( .A(n916), .B(\acc_out[0]_BAR ), .Q(n858) );
  BUFX24_HV U1136 ( .A(n517), .Q(n696) );
  NAND2X6_HV U1137 ( .A(n665), .B(n682), .Q(n994) );
  NOR2X12_HV U1138 ( .A(\thePAT/pc_immediate[7] ), .B(\thePAT/thePC/pc[7] ), 
        .Q(\thePAT/add_x_23/n23 ) );
  OAI21X8_HV U1139 ( .A1(\thePAT/add_x_23/n57 ), .A2(\thePAT/add_x_23/n60 ), 
        .B1(\thePAT/add_x_23/n58 ), .Q(\thePAT/add_x_23/n56 ) );
  NAND2X6_HV U1140 ( .A(\thePAT/thePC/pc[0] ), .B(\thePAT/pc_immediate[0] ), 
        .Q(\thePAT/add_x_23/n60 ) );
  NOR2X12_HV U1141 ( .A(\thePAT/pc_immediate[1] ), .B(\thePAT/thePC/pc[1] ), 
        .Q(\thePAT/add_x_23/n57 ) );
  NOR2X12_HV U1142 ( .A(n567), .B(n566), .Q(n970) );
  OR3X6_HV U1143 ( .A(n998), .B(n997), .C(n996), .Q(n1001) );
  AOI21X8_HV U1144 ( .A1(\thePAT/add_x_23/n48 ), .A2(\thePAT/add_x_23/n56 ), 
        .B1(\thePAT/add_x_23/n49 ), .Q(\thePAT/add_x_23/n47 ) );
  BUFX24_HV U1145 ( .A(\thePAT/n70 ), .Q(n665) );
  NOR2X3_HV U1146 ( .A(n800), .B(\thePAT/n27 ), .Q(n1525) );
  NOR2X3_HV U1147 ( .A(n800), .B(\thePAT/n28 ), .Q(n1524) );
  NAND2XL_HV U1148 ( .A(n1515), .B(n1514), .Q(\iBuffer/N31 ) );
  NAND2XL_HV U1149 ( .A(n1515), .B(n1492), .Q(\iBuffer/N42 ) );
  NAND2XL_HV U1150 ( .A(n1515), .B(n1496), .Q(\iBuffer/N40 ) );
  NAND2XL_HV U1151 ( .A(n1515), .B(n1498), .Q(\iBuffer/N39 ) );
  NAND2XL_HV U1152 ( .A(n1515), .B(n1500), .Q(\iBuffer/N38 ) );
  NAND2XL_HV U1153 ( .A(n1515), .B(n1502), .Q(\iBuffer/N37 ) );
  NAND2XL_HV U1154 ( .A(n1515), .B(n1504), .Q(\iBuffer/N36 ) );
  NAND2XL_HV U1155 ( .A(n1515), .B(n1509), .Q(\iBuffer/N33 ) );
  NAND2XL_HV U1156 ( .A(n1515), .B(n1487), .Q(\iBuffer/N45 ) );
  NAND2XL_HV U1157 ( .A(n1515), .B(n1494), .Q(\iBuffer/N41 ) );
  NAND2XL_HV U1158 ( .A(n1515), .B(n1506), .Q(\iBuffer/N35 ) );
  NAND3X3_HV U1159 ( .A(n1239), .B(n665), .C(n323), .Q(n1244) );
  OAI21X3_HV U1160 ( .A1(n296), .A2(\thePAT/opcode_i3[1] ), .B1(
        \thePAT/opcode_i3[2] ), .Q(n811) );
  NAND2X8_HV U1161 ( .A(n321), .B(\thePAT/n79 ), .Q(n1412) );
  NAND2X3_HV U1162 ( .A(n458), .B(acc_out[3]), .Q(n1387) );
  NAND2X3_HV U1163 ( .A(n458), .B(n1390), .Q(n1391) );
  NAND2XL_HV U1164 ( .A(n1273), .B(field_in[0]), .Q(n1275) );
  NOR2X3_HV U1165 ( .A(n800), .B(\thePAT/n26 ), .Q(n1526) );
  OAI21X3_HV U1166 ( .A1(n831), .A2(n1394), .B1(n1340), .Q(\thePAT/n808 ) );
  NOR2X12_HV U1167 ( .A(n802), .B(n820), .Q(n800) );
  NAND2X3_HV U1168 ( .A(\thePAT/pc_immediate[7] ), .B(\thePAT/thePC/pc[8] ), 
        .Q(\thePAT/add_x_23/n17 ) );
  CLKINVX2_HV U1169 ( .A(n1307), .Q(n1110) );
  INVXL_HV U1170 ( .A(n1299), .Q(n1300) );
  INVXL_HV U1171 ( .A(n1290), .Q(n1237) );
  OA21X2_HV U1172 ( .A1(field_in[1]), .A2(n85), .B1(n1226), .Q(n1227) );
  NAND2XL_HV U1173 ( .A(n678), .B(\thePAT/field_alu_b[5] ), .Q(n1235) );
  NOR2X3_HV U1174 ( .A(n388), .B(n1380), .Q(n1381) );
  OR3X3_HV U1175 ( .A(n108), .B(n251), .C(n518), .Q(n846) );
  NAND2X3_HV U1176 ( .A(\thePAT/thePC/pc[5] ), .B(\thePAT/pc_immediate[5] ), 
        .Q(\thePAT/add_x_23/n40 ) );
  NAND3X3_HV U1177 ( .A(n247), .B(n102), .C(\acc_out[4]_BAR ), .Q(n921) );
  OR2X3_HV U1178 ( .A(acc_out[4]), .B(n319), .Q(n301) );
  NAND2X6_HV U1179 ( .A(n838), .B(\thePAT/acc_alu_b[3] ), .Q(n1069) );
  NAND3X3_HV U1180 ( .A(n1320), .B(n695), .C(n241), .Q(n1179) );
  CLKINVX4_HV U1181 ( .A(\thePAT/field_alu_b[3] ), .Q(n550) );
  NOR2X3_HV U1182 ( .A(n815), .B(\thePAT/n35 ), .Q(\thePAT/op_mov ) );
  NOR3X3_HV U1183 ( .A(n805), .B(\thePAT/opcode_i3[0] ), .C(
        \thePAT/opcode_i3[3] ), .Q(\thePAT/op_shl ) );
  NAND2X3_HV U1184 ( .A(n458), .B(n249), .Q(n1385) );
  NAND2X3_HV U1185 ( .A(n458), .B(acc_out[2]), .Q(n1389) );
  NOR2X3_HV U1186 ( .A(n1074), .B(n116), .Q(n1076) );
  NOR2X3_HV U1187 ( .A(n800), .B(\thePAT/n25 ), .Q(n1527) );
  NOR2X3_HV U1188 ( .A(n800), .B(\thePAT/n29 ), .Q(n1523) );
  OR2X3_HV U1189 ( .A(\thePAT/n35 ), .B(n381), .Q(n1449) );
  CLKINVX2_HV U1190 ( .A(n1064), .Q(n1065) );
  NAND2X3_HV U1191 ( .A(\thePAT/field_alu_b[5] ), .B(field_in[5]), .Q(n1290)
         );
  NAND2X3_HV U1192 ( .A(n666), .B(n1526), .Q(n731) );
  NAND2X3_HV U1193 ( .A(n746), .B(\thePAT/data_read_adr[3] ), .Q(n752) );
  NAND2X3_HV U1194 ( .A(n818), .B(n297), .Q(n817) );
  CLKINVX2_HV U1195 ( .A(n903), .Q(n905) );
  NAND4X3_HV U1196 ( .A(n675), .B(n696), .C(n417), .D(\acc_out[0]_BAR ), .Q(
        n898) );
  NAND2X3_HV U1197 ( .A(n1202), .B(n1366), .Q(n1203) );
  NAND2X3_HV U1198 ( .A(n616), .B(n1265), .Q(n1266) );
  NAND2X3_HV U1199 ( .A(n1273), .B(n1258), .Q(n1259) );
  CLKINVX2_HV U1200 ( .A(n1345), .Q(n1252) );
  NAND2X3_HV U1201 ( .A(n1060), .B(acc_out[3]), .Q(n1061) );
  NAND2X3_HV U1202 ( .A(n987), .B(n1066), .Q(n989) );
  NAND2X3_HV U1203 ( .A(n1026), .B(n1027), .Q(n603) );
  CLKINVX2_HV U1204 ( .A(n1019), .Q(n1020) );
  NOR2X3_HV U1205 ( .A(n677), .B(n1011), .Q(n1009) );
  AOI22X3_HV U1206 ( .A1(n789), .A2(\thePAT/dmem/dmem[4][7] ), .B1(n668), .B2(
        \thePAT/dmem/dmem[2][7] ), .Q(n713) );
  NOR2X3_HV U1207 ( .A(n518), .B(n249), .Q(n416) );
  CLKINVX2_HV U1208 ( .A(n962), .Q(n963) );
  NAND3X3_HV U1209 ( .A(n616), .B(n675), .C(\thePAT/n74 ), .Q(n956) );
  CLKINVX2_HV U1210 ( .A(\DP_OP_104_132_4164/n34 ), .Q(
        \DP_OP_104_132_4164/n47 ) );
  CLKINVX2_HV U1211 ( .A(n951), .Q(n953) );
  NAND2X3_HV U1212 ( .A(n147), .B(acc_out[3]), .Q(n1101) );
  NAND2X3_HV U1213 ( .A(n1090), .B(n1205), .Q(n1091) );
  CLKINVX2_HV U1214 ( .A(n241), .Q(n571) );
  NAND2X3_HV U1215 ( .A(\DP_OP_108_135_5866/n67 ), .B(n1265), .Q(n1226) );
  NAND2X3_HV U1216 ( .A(n565), .B(field_in[5]), .Q(n564) );
  NAND2X3_HV U1217 ( .A(n441), .B(n517), .Q(n1359) );
  NAND2X3_HV U1218 ( .A(n967), .B(n969), .Q(n854) );
  CLKINVX2_HV U1219 ( .A(n975), .Q(n859) );
  NAND2X3_HV U1220 ( .A(n429), .B(n841), .Q(n428) );
  NOR2X6_HV U1221 ( .A(\thePAT/thePC/pc[2] ), .B(\thePAT/pc_immediate[2] ), 
        .Q(\thePAT/add_x_23/n53 ) );
  OA21X6_HV U1222 ( .A1(n508), .A2(n934), .B1(n1047), .Q(n507) );
  NAND3X3_HV U1223 ( .A(n930), .B(n1392), .C(n1040), .Q(n931) );
  NAND3X3_HV U1224 ( .A(n616), .B(n619), .C(n1239), .Q(n929) );
  CLKINVX2_HV U1225 ( .A(\DP_OP_104_132_4164/n24 ), .Q(
        \DP_OP_104_132_4164/n44 ) );
  NOR2X12_HV U1226 ( .A(n448), .B(n447), .Q(n1008) );
  CLKINVX4_HV U1227 ( .A(n1069), .Q(n499) );
  CLKINVX2_HV U1228 ( .A(\thePAT/add_x_23/n57 ), .Q(\thePAT/add_x_23/n69 ) );
  NAND3X3_HV U1229 ( .A(n419), .B(n295), .C(n425), .Q(n418) );
  AOI22X3_HV U1230 ( .A1(n671), .A2(\thePAT/dmem/dmem[7][4] ), .B1(n672), .B2(
        \thePAT/dmem/dmem[6][4] ), .Q(n747) );
  AOI22X3_HV U1231 ( .A1(n789), .A2(\thePAT/dmem/dmem[4][4] ), .B1(n401), .B2(
        \thePAT/dmem/dmem[2][4] ), .Q(n749) );
  AOI22X3_HV U1232 ( .A1(n669), .A2(\thePAT/dmem/dmem[3][4] ), .B1(n670), .B2(
        \thePAT/dmem/dmem[0][4] ), .Q(n748) );
  NOR2X3_HV U1233 ( .A(n1201), .B(n1265), .Q(n1188) );
  OAI21X3_HV U1234 ( .A1(n677), .A2(n250), .B1(n679), .Q(n1264) );
  NOR2X3_HV U1235 ( .A(n1323), .B(field_in[0]), .Q(n1261) );
  NOR2X3_HV U1236 ( .A(n1252), .B(n1251), .Q(n1253) );
  NAND2X3_HV U1237 ( .A(n1057), .B(n1056), .Q(n1058) );
  NOR2X3_HV U1238 ( .A(n677), .B(n127), .Q(n404) );
  NAND3X3_HV U1239 ( .A(n616), .B(n675), .C(n127), .Q(n1054) );
  NOR2X3_HV U1240 ( .A(n677), .B(n165), .Q(n1133) );
  NAND2X3_HV U1241 ( .A(n982), .B(n301), .Q(n983) );
  NOR2X3_HV U1242 ( .A(n677), .B(\acc_out[4]_BAR ), .Q(n976) );
  NAND2X3_HV U1243 ( .A(n952), .B(n953), .Q(n511) );
  CLKINVX2_HV U1244 ( .A(n1315), .Q(n1316) );
  NAND2X3_HV U1245 ( .A(\thePAT/field_alu_b[7] ), .B(field_in[7]), .Q(n1321)
         );
  NAND2X3_HV U1246 ( .A(n572), .B(n571), .Q(n570) );
  CLKINVX2_HV U1247 ( .A(n1227), .Q(n572) );
  NAND2X3_HV U1248 ( .A(n1374), .B(n481), .Q(n562) );
  NAND2X3_HV U1249 ( .A(n1371), .B(n564), .Q(n563) );
  NOR2X3_HV U1250 ( .A(n852), .B(n851), .Q(n853) );
  CLKINVX4_HV U1251 ( .A(\thePAT/n75 ), .Q(n1390) );
  CLKINVX2_HV U1252 ( .A(\thePAT/add_x_22/n14 ), .Q(\thePAT/add_x_22/n15 ) );
  NAND3X3_HV U1253 ( .A(n675), .B(acc_out[5]), .C(n521), .Q(n928) );
  CLKINVX4_HV U1254 ( .A(n1077), .Q(n1031) );
  NAND2X3_HV U1255 ( .A(n865), .B(n999), .Q(n868) );
  OA21X6_HV U1256 ( .A1(n464), .A2(n463), .B1(n875), .Q(n362) );
  NAND2X3_HV U1257 ( .A(n1060), .B(acc_out[7]), .Q(n875) );
  CLKINVX2_HV U1258 ( .A(n864), .Q(n519) );
  NAND2X3_HV U1259 ( .A(n981), .B(n1030), .Q(n463) );
  NAND2X3_HV U1260 ( .A(acc_out[6]), .B(n142), .Q(n880) );
  NAND2X3_HV U1261 ( .A(n284), .B(\thePAT/op_shlo_regd ), .Q(n1105) );
  NOR2XL_HV U1262 ( .A(n813), .B(n819), .Q(\thePAT/op_and ) );
  NAND2X3_HV U1263 ( .A(n453), .B(n1525), .Q(n456) );
  NAND2X3_HV U1264 ( .A(n799), .B(\thePAT/immediate_i8[1] ), .Q(n780) );
  AOI22X3_HV U1265 ( .A1(n788), .A2(\thePAT/dmem/dmem[5][4] ), .B1(n667), .B2(
        \thePAT/dmem/dmem[1][4] ), .Q(n750) );
  AND2X6_HV U1266 ( .A(n1486), .B(n1485), .Q(n1515) );
  OAI31X3_HV U1267 ( .A1(n1245), .A2(n1244), .A3(n1243), .B1(n1242), .Q(n1247)
         );
  NAND2X3_HV U1268 ( .A(n453), .B(\thePAT/immediate_i8[2] ), .Q(n445) );
  NAND2X3_HV U1269 ( .A(n812), .B(n811), .Q(n816) );
  NAND3X12_HV U1270 ( .A(n305), .B(n396), .C(n395), .Q(n1407) );
  NOR2X12_HV U1271 ( .A(n1394), .B(\thePAT/data_write_adr[6] ), .Q(n396) );
  NOR2X6_HV U1272 ( .A(n1450), .B(n1449), .Q(n1451) );
  CLKINVX2_HV U1273 ( .A(\thePAT/add_x_23/n68 ), .Q(n623) );
  CLKINVX2_HV U1274 ( .A(\thePAT/add_x_23/n39 ), .Q(\thePAT/add_x_23/n65 ) );
  NAND2X3_HV U1275 ( .A(n678), .B(n248), .Q(n1211) );
  NOR3X3_HV U1276 ( .A(n1360), .B(n248), .C(n1358), .Q(n1191) );
  NAND2X3_HV U1277 ( .A(n1197), .B(n1198), .Q(n541) );
  NOR2X3_HV U1278 ( .A(n1323), .B(n1308), .Q(n1198) );
  NAND2X3_HV U1279 ( .A(n163), .B(field_in[1]), .Q(n1274) );
  NAND2X3_HV U1280 ( .A(n1070), .B(n1071), .Q(n1080) );
  NAND2X3_HV U1281 ( .A(n799), .B(n1527), .Q(n716) );
  CLKINVX2_HV U1282 ( .A(n1067), .Q(n952) );
  NOR2X3_HV U1283 ( .A(n1372), .B(n1308), .Q(n1113) );
  NAND2X3_HV U1284 ( .A(n1101), .B(n1100), .Q(n1102) );
  NOR2X3_HV U1285 ( .A(n679), .B(n1327), .Q(n1328) );
  CLKINVX2_HV U1286 ( .A(n1374), .Q(n1356) );
  CLKINVX2_HV U1287 ( .A(\DP_OP_104_132_4164/n23 ), .Q(
        \DP_OP_104_132_4164/n21 ) );
  NAND2X3_HV U1288 ( .A(n525), .B(\DP_OP_104_132_4164/n22 ), .Q(n524) );
  CLKINVX2_HV U1289 ( .A(\thePAT/add_x_23/n33 ), .Q(\thePAT/add_x_23/n35 ) );
  CLKINVX2_HV U1290 ( .A(n679), .Q(n521) );
  NAND2X3_HV U1291 ( .A(n390), .B(n882), .Q(n886) );
  OA21X6_HV U1292 ( .A1(n1073), .A2(n499), .B1(n1068), .Q(n310) );
  NAND2X3_HV U1293 ( .A(n882), .B(n472), .Q(n471) );
  NOR2X3_HV U1294 ( .A(n1368), .B(n1348), .Q(n1151) );
  NOR2X3_HV U1295 ( .A(n1309), .B(n1265), .Q(n1150) );
  NAND2X3_HV U1296 ( .A(\thePAT/field_alu_b[3] ), .B(field_in[3]), .Q(n1145)
         );
  NAND2XL_HV U1297 ( .A(n325), .B(\thePAT/opcode_i8[0] ), .Q(n819) );
  NAND3X12_HV U1298 ( .A(n1408), .B(\thePAT/n80 ), .C(n306), .Q(n1403) );
  AOI22X3_HV U1299 ( .A1(n671), .A2(\thePAT/dmem/dmem[15][4] ), .B1(n672), 
        .B2(\thePAT/dmem/dmem[14][4] ), .Q(n742) );
  AOI22X3_HV U1300 ( .A1(n669), .A2(\thePAT/dmem/dmem[11][4] ), .B1(n670), 
        .B2(\thePAT/dmem/dmem[8][4] ), .Q(n743) );
  AOI22X3_HV U1301 ( .A1(n789), .A2(\thePAT/dmem/dmem[12][4] ), .B1(n401), 
        .B2(\thePAT/dmem/dmem[10][4] ), .Q(n744) );
  AOI22X3_HV U1302 ( .A1(n788), .A2(\thePAT/dmem/dmem[13][4] ), .B1(n667), 
        .B2(\thePAT/dmem/dmem[9][4] ), .Q(n745) );
  NAND2X3_HV U1303 ( .A(n765), .B(\thePAT/data_read_adr[3] ), .Q(n770) );
  NAND2X12_HV U1304 ( .A(n306), .B(n1405), .Q(n1401) );
  CLKINVX2_HV U1305 ( .A(n453), .Q(n451) );
  NAND2X3_HV U1306 ( .A(n786), .B(\thePAT/data_read_adr[3] ), .Q(n798) );
  NAND2X12_HV U1307 ( .A(n336), .B(\thePAT/n78 ), .Q(n1415) );
  NAND3X12_HV U1308 ( .A(\thePAT/n77 ), .B(\thePAT/n80 ), .C(n1408), .Q(n1419)
         );
  NAND2X12_HV U1309 ( .A(\thePAT/n79 ), .B(\thePAT/n78 ), .Q(n1420) );
  NOR2X12_HV U1310 ( .A(n1407), .B(\thePAT/n80 ), .Q(n1405) );
  NOR2X12_HV U1311 ( .A(\thePAT/data_write_adr[4] ), .B(
        \thePAT/data_write_adr[5] ), .Q(n395) );
  CLKINVX2_HV U1312 ( .A(\thePAT/add_x_23/n53 ), .Q(\thePAT/add_x_23/n68 ) );
  CLKINVX2_HV U1313 ( .A(n837), .Q(n832) );
  NOR2X3_HV U1314 ( .A(n1188), .B(n1187), .Q(n1189) );
  NOR2X3_HV U1315 ( .A(n1272), .B(n1271), .Q(n1276) );
  NOR2X3_HV U1316 ( .A(n1022), .B(n894), .Q(n1263) );
  CLKINVX2_HV U1317 ( .A(n1071), .Q(n1074) );
  NAND3X3_HV U1318 ( .A(n1020), .B(\thePAT/field_value[1] ), .C(n503), .Q(
        n1026) );
  NAND4X3_HV U1319 ( .A(n1017), .B(n1016), .C(n1015), .D(n1014), .Q(n1018) );
  NAND2X3_HV U1320 ( .A(n710), .B(\thePAT/data_read_adr[3] ), .Q(n718) );
  NAND2X3_HV U1321 ( .A(n423), .B(n446), .Q(n422) );
  NAND2X3_HV U1322 ( .A(n757), .B(\thePAT/data_read_adr[3] ), .Q(n760) );
  NOR2X3_HV U1323 ( .A(n809), .B(n808), .Q(n699) );
  NAND2X3_HV U1324 ( .A(n979), .B(n1027), .Q(n980) );
  NAND2X3_HV U1325 ( .A(\thePAT/thePC/pc[6] ), .B(\thePAT/thePC/pc[7] ), .Q(
        \thePAT/add_x_22/n6 ) );
  NAND3X3_HV U1326 ( .A(n1067), .B(n951), .C(n130), .Q(n510) );
  NOR2X3_HV U1327 ( .A(n951), .B(n130), .Q(n513) );
  NAND2X3_HV U1328 ( .A(n1073), .B(n1064), .Q(n951) );
  CLKINVX2_HV U1329 ( .A(n1298), .Q(n1301) );
  CLKINVX2_HV U1330 ( .A(n1378), .Q(n1288) );
  NOR2X3_HV U1331 ( .A(n1233), .B(n1228), .Q(n576) );
  CLKINVX2_HV U1332 ( .A(n629), .Q(n565) );
  NOR2X3_HV U1333 ( .A(n294), .B(n684), .Q(n575) );
  NOR2X3_HV U1334 ( .A(n1358), .B(\DP_OP_108_135_5866/n52 ), .Q(n441) );
  CLKINVX2_HV U1335 ( .A(n678), .Q(n1053) );
  CLKINVX2_HV U1336 ( .A(n841), .Q(n431) );
  AND2X6_HV U1337 ( .A(n643), .B(n644), .Q(n1423) );
  NOR2X3_HV U1338 ( .A(\thePAT/add_x_23/n35 ), .B(\thePAT/add_x_23/n28 ), .Q(
        \thePAT/add_x_23/n26 ) );
  NOR2X3_HV U1339 ( .A(n1088), .B(n919), .Q(n1005) );
  NAND3X3_HV U1340 ( .A(n346), .B(n651), .C(n1095), .Q(n919) );
  NAND2X3_HV U1341 ( .A(n1571), .B(n645), .Q(n1068) );
  NOR2X3_HV U1342 ( .A(n1022), .B(n977), .Q(n1175) );
  NOR2X3_HV U1343 ( .A(\thePAT/op_shl_regd ), .B(\thePAT/op_add_addm_regd_2 ), 
        .Q(n1106) );
  NOR2X3_HV U1344 ( .A(n1152), .B(n1151), .Q(n1153) );
  NAND2X3_HV U1345 ( .A(n1095), .B(\thePAT/op_add_addm_regd_2 ), .Q(n1096) );
  NOR3X1_HV U1346 ( .A(n813), .B(\thePAT/opcode_i8[2] ), .C(
        \thePAT/opcode_i8[0] ), .Q(\thePAT/op_or ) );
  NOR2X12_HV U1347 ( .A(n1403), .B(n1409), .Q(n1396) );
  NOR2X12_HV U1348 ( .A(n1403), .B(n1420), .Q(n1404) );
  NOR2X12_HV U1349 ( .A(n1415), .B(n1403), .Q(n1400) );
  NOR2X12_HV U1350 ( .A(n1412), .B(n1403), .Q(n1398) );
  NAND2X3_HV U1351 ( .A(n1438), .B(n1437), .Q(\thePAT/n14 ) );
  NAND2X3_HV U1352 ( .A(n1440), .B(n1439), .Q(\thePAT/n13 ) );
  NAND2X3_HV U1353 ( .A(n139), .B(\thePAT/thePC/pcInc[2] ), .Q(n1426) );
  NAND2X3_HV U1354 ( .A(n135), .B(\thePAT/thePC/pcAdd[2] ), .Q(n1427) );
  AOI22X3_HV U1355 ( .A1(n788), .A2(\thePAT/dmem/dmem[5][5] ), .B1(n667), .B2(
        \thePAT/dmem/dmem[1][5] ), .Q(n740) );
  AOI22X3_HV U1356 ( .A1(n669), .A2(\thePAT/dmem/dmem[3][5] ), .B1(n670), .B2(
        \thePAT/dmem/dmem[0][5] ), .Q(n738) );
  AOI22X3_HV U1357 ( .A1(n789), .A2(\thePAT/dmem/dmem[4][5] ), .B1(n401), .B2(
        \thePAT/dmem/dmem[2][5] ), .Q(n739) );
  AOI22X3_HV U1358 ( .A1(n671), .A2(\thePAT/dmem/dmem[7][5] ), .B1(n672), .B2(
        \thePAT/dmem/dmem[6][5] ), .Q(n737) );
  NAND2X3_HV U1359 ( .A(n736), .B(\thePAT/data_read_adr[3] ), .Q(n741) );
  AOI22X3_HV U1360 ( .A1(n671), .A2(\thePAT/dmem/dmem[15][5] ), .B1(n672), 
        .B2(\thePAT/dmem/dmem[14][5] ), .Q(n732) );
  AOI22X3_HV U1361 ( .A1(n669), .A2(\thePAT/dmem/dmem[11][5] ), .B1(n670), 
        .B2(\thePAT/dmem/dmem[8][5] ), .Q(n733) );
  AOI22X3_HV U1362 ( .A1(n789), .A2(\thePAT/dmem/dmem[12][5] ), .B1(n401), 
        .B2(\thePAT/dmem/dmem[10][5] ), .Q(n734) );
  AOI22X3_HV U1363 ( .A1(n788), .A2(\thePAT/dmem/dmem[13][5] ), .B1(n667), 
        .B2(\thePAT/dmem/dmem[9][5] ), .Q(n735) );
  AOI22X3_HV U1364 ( .A1(n788), .A2(\thePAT/dmem/dmem[5][1] ), .B1(n667), .B2(
        \thePAT/dmem/dmem[1][1] ), .Q(n779) );
  AOI22X3_HV U1365 ( .A1(n671), .A2(\thePAT/dmem/dmem[7][1] ), .B1(n672), .B2(
        \thePAT/dmem/dmem[6][1] ), .Q(n776) );
  AOI22X3_HV U1366 ( .A1(n789), .A2(\thePAT/dmem/dmem[4][1] ), .B1(n401), .B2(
        \thePAT/dmem/dmem[2][1] ), .Q(n778) );
  AOI22X3_HV U1367 ( .A1(n669), .A2(\thePAT/dmem/dmem[3][1] ), .B1(n670), .B2(
        \thePAT/dmem/dmem[0][1] ), .Q(n777) );
  NAND2X3_HV U1368 ( .A(n775), .B(\thePAT/data_read_adr[3] ), .Q(n781) );
  AOI22X3_HV U1369 ( .A1(n671), .A2(\thePAT/dmem/dmem[15][1] ), .B1(n672), 
        .B2(\thePAT/dmem/dmem[14][1] ), .Q(n771) );
  AOI22X3_HV U1370 ( .A1(n669), .A2(\thePAT/dmem/dmem[11][1] ), .B1(n670), 
        .B2(\thePAT/dmem/dmem[8][1] ), .Q(n772) );
  AOI22X3_HV U1371 ( .A1(n789), .A2(\thePAT/dmem/dmem[12][1] ), .B1(n401), 
        .B2(\thePAT/dmem/dmem[10][1] ), .Q(n773) );
  AOI22X3_HV U1372 ( .A1(n788), .A2(\thePAT/dmem/dmem[13][1] ), .B1(n667), 
        .B2(\thePAT/dmem/dmem[9][1] ), .Q(n774) );
  AOI22X3_HV U1373 ( .A1(n788), .A2(\thePAT/dmem/dmem[5][2] ), .B1(n667), .B2(
        \thePAT/dmem/dmem[1][2] ), .Q(n769) );
  AOI22X3_HV U1374 ( .A1(n669), .A2(\thePAT/dmem/dmem[3][2] ), .B1(n670), .B2(
        \thePAT/dmem/dmem[0][2] ), .Q(n767) );
  AOI22X3_HV U1375 ( .A1(n789), .A2(\thePAT/dmem/dmem[4][2] ), .B1(n401), .B2(
        \thePAT/dmem/dmem[2][2] ), .Q(n768) );
  AOI22X3_HV U1376 ( .A1(n671), .A2(\thePAT/dmem/dmem[7][2] ), .B1(n672), .B2(
        \thePAT/dmem/dmem[6][2] ), .Q(n766) );
  AOI22X3_HV U1377 ( .A1(n671), .A2(\thePAT/dmem/dmem[15][2] ), .B1(n672), 
        .B2(\thePAT/dmem/dmem[14][2] ), .Q(n761) );
  AOI22X3_HV U1378 ( .A1(n669), .A2(\thePAT/dmem/dmem[11][2] ), .B1(n670), 
        .B2(\thePAT/dmem/dmem[8][2] ), .Q(n762) );
  AOI22X3_HV U1379 ( .A1(n789), .A2(\thePAT/dmem/dmem[12][2] ), .B1(n401), 
        .B2(\thePAT/dmem/dmem[10][2] ), .Q(n763) );
  AOI22X3_HV U1380 ( .A1(n788), .A2(\thePAT/dmem/dmem[13][2] ), .B1(n667), 
        .B2(\thePAT/dmem/dmem[9][2] ), .Q(n764) );
  NOR2X12_HV U1381 ( .A(n1401), .B(n1412), .Q(n1397) );
  NOR2X12_HV U1382 ( .A(n1401), .B(n1409), .Q(n1395) );
  NOR2X12_HV U1383 ( .A(n1401), .B(n1415), .Q(n1399) );
  NOR2X12_HV U1384 ( .A(n1401), .B(n1420), .Q(n1402) );
  NAND3X3_HV U1385 ( .A(\thePAT/n35 ), .B(\thePAT/opcode_i8[0] ), .C(n329), 
        .Q(n810) );
  NOR2X12_HV U1386 ( .A(n1417), .B(n1409), .Q(n1406) );
  NOR2X12_HV U1387 ( .A(n1417), .B(n1420), .Q(n1418) );
  AOI22X3_HV U1388 ( .A1(n788), .A2(\thePAT/dmem/dmem[5][0] ), .B1(n667), .B2(
        \thePAT/dmem/dmem[1][0] ), .Q(n797) );
  AOI22X3_HV U1389 ( .A1(n669), .A2(\thePAT/dmem/dmem[3][0] ), .B1(n670), .B2(
        \thePAT/dmem/dmem[0][0] ), .Q(n795) );
  AOI22X3_HV U1390 ( .A1(n789), .A2(\thePAT/dmem/dmem[4][0] ), .B1(n401), .B2(
        \thePAT/dmem/dmem[2][0] ), .Q(n796) );
  AOI22X3_HV U1391 ( .A1(n671), .A2(\thePAT/dmem/dmem[7][0] ), .B1(n672), .B2(
        \thePAT/dmem/dmem[6][0] ), .Q(n794) );
  AOI22X3_HV U1392 ( .A1(n671), .A2(\thePAT/dmem/dmem[15][0] ), .B1(n672), 
        .B2(\thePAT/dmem/dmem[14][0] ), .Q(n782) );
  AOI22X3_HV U1393 ( .A1(n669), .A2(\thePAT/dmem/dmem[11][0] ), .B1(n670), 
        .B2(\thePAT/dmem/dmem[8][0] ), .Q(n783) );
  AOI22X3_HV U1394 ( .A1(n789), .A2(\thePAT/dmem/dmem[12][0] ), .B1(n401), 
        .B2(\thePAT/dmem/dmem[10][0] ), .Q(n784) );
  AOI22X3_HV U1395 ( .A1(n788), .A2(\thePAT/dmem/dmem[13][0] ), .B1(n667), 
        .B2(\thePAT/dmem/dmem[9][0] ), .Q(n785) );
  NOR2X12_HV U1396 ( .A(n1409), .B(n1419), .Q(n1410) );
  NOR2X12_HV U1397 ( .A(n1412), .B(n1419), .Q(n1413) );
  NOR2X12_HV U1398 ( .A(n1415), .B(n1419), .Q(n1416) );
  NOR2X12_HV U1399 ( .A(n1420), .B(n1419), .Q(n1421) );
  NOR2X12_HV U1400 ( .A(n1412), .B(n1417), .Q(n1411) );
  AND3X6_HV U1401 ( .A(n1486), .B(n1485), .C(n138), .Q(n1511) );
  AND3X6_HV U1402 ( .A(n1486), .B(n160), .C(n1485), .Q(n1512) );
  NAND2X3_HV U1403 ( .A(\thePAT/opcode_i8[0] ), .B(n87), .Q(n1453) );
  NAND2X3_HV U1404 ( .A(n1442), .B(n1441), .Q(\thePAT/n12 ) );
  NAND2X3_HV U1405 ( .A(\thePAT/thePC/pcInc[3] ), .B(n139), .Q(n1428) );
  NAND2X3_HV U1406 ( .A(n308), .B(n911), .Q(n516) );
  NOR2X3_HV U1407 ( .A(n978), .B(n102), .Q(n912) );
  NAND3X3_HV U1408 ( .A(n897), .B(n528), .C(n675), .Q(n900) );
  NAND2X3_HV U1409 ( .A(\thePAT/thePC/pcInc[5] ), .B(n139), .Q(n1432) );
  NOR2X3_HV U1410 ( .A(n539), .B(n538), .Q(n537) );
  NAND2X3_HV U1411 ( .A(\thePAT/thePC/pcInc[6] ), .B(n139), .Q(n509) );
  NOR2X3_HV U1412 ( .A(n1270), .B(n241), .Q(n1279) );
  AOI22X3_HV U1413 ( .A1(n671), .A2(\thePAT/dmem/dmem[7][6] ), .B1(n672), .B2(
        \thePAT/dmem/dmem[6][6] ), .Q(n724) );
  AOI22X3_HV U1414 ( .A1(n669), .A2(\thePAT/dmem/dmem[3][6] ), .B1(n670), .B2(
        \thePAT/dmem/dmem[0][6] ), .Q(n725) );
  AOI22X3_HV U1415 ( .A1(n789), .A2(\thePAT/dmem/dmem[4][6] ), .B1(n401), .B2(
        \thePAT/dmem/dmem[2][6] ), .Q(n726) );
  AOI22X3_HV U1416 ( .A1(n788), .A2(\thePAT/dmem/dmem[5][6] ), .B1(n667), .B2(
        \thePAT/dmem/dmem[1][6] ), .Q(n727) );
  AOI22X3_HV U1417 ( .A1(n671), .A2(\thePAT/dmem/dmem[15][6] ), .B1(n672), 
        .B2(\thePAT/dmem/dmem[14][6] ), .Q(n719) );
  AOI22X3_HV U1418 ( .A1(n669), .A2(\thePAT/dmem/dmem[11][6] ), .B1(n670), 
        .B2(\thePAT/dmem/dmem[8][6] ), .Q(n720) );
  AOI22X3_HV U1419 ( .A1(n789), .A2(\thePAT/dmem/dmem[12][6] ), .B1(n401), 
        .B2(\thePAT/dmem/dmem[10][6] ), .Q(n721) );
  AOI22X3_HV U1420 ( .A1(n788), .A2(\thePAT/dmem/dmem[13][6] ), .B1(n667), 
        .B2(\thePAT/dmem/dmem[9][6] ), .Q(n722) );
  NOR2X12_HV U1421 ( .A(n824), .B(n182), .Q(n459) );
  AOI22X3_HV U1422 ( .A1(n671), .A2(\thePAT/dmem/dmem[7][7] ), .B1(n672), .B2(
        \thePAT/dmem/dmem[6][7] ), .Q(n711) );
  AOI22X3_HV U1423 ( .A1(n669), .A2(\thePAT/dmem/dmem[3][7] ), .B1(n670), .B2(
        \thePAT/dmem/dmem[0][7] ), .Q(n712) );
  AOI22X3_HV U1424 ( .A1(n788), .A2(\thePAT/dmem/dmem[5][7] ), .B1(n667), .B2(
        \thePAT/dmem/dmem[1][7] ), .Q(n714) );
  AOI22X3_HV U1425 ( .A1(n671), .A2(\thePAT/dmem/dmem[15][7] ), .B1(n672), 
        .B2(\thePAT/dmem/dmem[14][7] ), .Q(n706) );
  AOI22X3_HV U1426 ( .A1(n669), .A2(\thePAT/dmem/dmem[11][7] ), .B1(n670), 
        .B2(\thePAT/dmem/dmem[8][7] ), .Q(n707) );
  AOI22X3_HV U1427 ( .A1(n789), .A2(\thePAT/dmem/dmem[12][7] ), .B1(n401), 
        .B2(\thePAT/dmem/dmem[10][7] ), .Q(n708) );
  AOI22X3_HV U1428 ( .A1(n788), .A2(\thePAT/dmem/dmem[13][7] ), .B1(n667), 
        .B2(\thePAT/dmem/dmem[9][7] ), .Q(n709) );
  AOI22X3_HV U1429 ( .A1(n671), .A2(\thePAT/dmem/dmem[15][3] ), .B1(n672), 
        .B2(\thePAT/dmem/dmem[14][3] ), .Q(n753) );
  AOI22X3_HV U1430 ( .A1(n669), .A2(\thePAT/dmem/dmem[11][3] ), .B1(n670), 
        .B2(\thePAT/dmem/dmem[8][3] ), .Q(n754) );
  AOI22X3_HV U1431 ( .A1(n789), .A2(\thePAT/dmem/dmem[12][3] ), .B1(n401), 
        .B2(\thePAT/dmem/dmem[10][3] ), .Q(n755) );
  AOI22X3_HV U1432 ( .A1(n788), .A2(\thePAT/dmem/dmem[13][3] ), .B1(n667), 
        .B2(\thePAT/dmem/dmem[9][3] ), .Q(n756) );
  NAND2X3_HV U1433 ( .A(\thePAT/thePC/pcInc[4] ), .B(n139), .Q(n1431) );
  NOR2X3_HV U1434 ( .A(n1027), .B(n674), .Q(n985) );
  CLKINVX6_HV U1435 ( .A(n673), .Q(n1340) );
  NOR2X3_HV U1436 ( .A(n493), .B(n1120), .Q(n1121) );
  NOR2X3_HV U1437 ( .A(n1119), .B(n695), .Q(n1120) );
  OAI21X3_HV U1438 ( .A1(n1160), .A2(n1348), .B1(\DP_OP_108_135_5866/n52 ), 
        .Q(n1114) );
  NOR2X3_HV U1439 ( .A(n1292), .B(n1237), .Q(n1238) );
  OR3X3_HV U1440 ( .A(n1370), .B(n248), .C(field_in[5]), .Q(n365) );
  OR3X3_HV U1441 ( .A(n684), .B(\DP_OP_108_135_5866/n67 ), .C(field_in[5]), 
        .Q(n1223) );
  OR3X3_HV U1442 ( .A(n1370), .B(n248), .C(n1369), .Q(n1371) );
  NOR2X3_HV U1443 ( .A(n1360), .B(n1359), .Q(n1361) );
  AOI21X3_HV U1444 ( .A1(n676), .A2(n108), .B1(n903), .Q(n374) );
  NAND2X3_HV U1445 ( .A(\thePAT/thePC/pc[4] ), .B(\thePAT/thePC/pc[5] ), .Q(
        \thePAT/add_x_22/n14 ) );
  CLKINVX2_HV U1446 ( .A(n656), .Q(n640) );
  NOR2X6_HV U1447 ( .A(\thePAT/opcode_i8[2] ), .B(n1422), .Q(n1454) );
  NOR2X3_HV U1448 ( .A(\thePAT/add_x_23/n53 ), .B(\thePAT/add_x_23/n50 ), .Q(
        \thePAT/add_x_23/n48 ) );
  CLKINVX2_HV U1449 ( .A(n311), .Q(n982) );
  NOR2X3_HV U1450 ( .A(n1022), .B(n889), .Q(n1329) );
  NAND2X3_HV U1451 ( .A(n1376), .B(n1180), .Q(n1181) );
  NOR2X3_HV U1452 ( .A(n807), .B(n117), .Q(n1521) );
  NOR2X3_HV U1453 ( .A(n807), .B(\thePAT/opcode_i8[0] ), .Q(n1522) );
  NOR2X3_HV U1454 ( .A(n815), .B(n315), .Q(\thePAT/op_not ) );
  NOR3X3_HV U1455 ( .A(n805), .B(\thePAT/opcode_i3[3] ), .C(n296), .Q(
        \thePAT/op_shlo ) );
  NOR3X3_HV U1456 ( .A(n805), .B(\thePAT/opcode_i3[0] ), .C(n316), .Q(
        \thePAT/op_out ) );
  AOI21X3_HV U1457 ( .A1(n1456), .A2(n1455), .B1(reset), .Q(\iBuffer/n63 ) );
  AO31X3_HV U1458 ( .A1(n1456), .A2(\iBuffer/jump_bubble[1] ), .A3(n320), .B1(
        reset), .Q(\iBuffer/n64 ) );
  NAND4X3_HV U1459 ( .A(n737), .B(n739), .C(n738), .D(n740), .Q(n455) );
  NAND3X3_HV U1460 ( .A(n426), .B(n295), .C(n425), .Q(n424) );
  NAND4X3_HV U1461 ( .A(n774), .B(n773), .C(n772), .D(n771), .Q(n775) );
  NAND4X3_HV U1462 ( .A(n745), .B(n744), .C(n743), .D(n742), .Q(n746) );
  NAND3X3_HV U1463 ( .A(n1241), .B(n1240), .C(\thePAT/field_op_regd ), .Q(
        n1242) );
  NOR4X3_HV U1464 ( .A(\thePAT/field_value[6] ), .B(\thePAT/field_value[5] ), 
        .C(\thePAT/field_value[2] ), .D(\thePAT/field_value[3] ), .Q(n1240) );
  NOR4X3_HV U1465 ( .A(\thePAT/field_value[1] ), .B(\thePAT/field_value[7] ), 
        .C(\thePAT/field_value[4] ), .D(\thePAT/field_value[0] ), .Q(n1241) );
  NAND4X3_HV U1466 ( .A(\acc_out[4]_BAR ), .B(n318), .C(\acc_out[1]_BAR ), .D(
        \acc_out[0]_BAR ), .Q(n1245) );
  NOR3X3_HV U1467 ( .A(\thePAT/opcode_i0[2] ), .B(\thePAT/opcode_i0[3] ), .C(
        n381), .Q(n825) );
  NOR4X3_HV U1468 ( .A(n822), .B(\thePAT/opcode_i3[1] ), .C(n296), .D(n328), 
        .Q(\thePAT/op_in ) );
  NAND3X3_HV U1469 ( .A(n444), .B(n443), .C(n295), .Q(n442) );
  NAND4X3_HV U1470 ( .A(n769), .B(n768), .C(n767), .D(n766), .Q(n443) );
  NAND4X3_HV U1471 ( .A(n764), .B(n763), .C(n762), .D(n761), .Q(n765) );
  CLKINVX2_HV U1472 ( .A(n627), .Q(n628) );
  NAND4X3_HV U1473 ( .A(n817), .B(n816), .C(n383), .D(n815), .Q(n823) );
  NAND2X3_HV U1474 ( .A(n1452), .B(n804), .Q(n815) );
  NOR2X3_HV U1475 ( .A(n1450), .B(\thePAT/opcode_i0[1] ), .Q(n804) );
  NAND4X3_HV U1476 ( .A(n785), .B(n784), .C(n783), .D(n782), .Q(n786) );
  OAI21X3_HV U1477 ( .A1(n458), .A2(n330), .B1(n1384), .Q(\thePAT/n783 ) );
  OAI21X3_HV U1478 ( .A1(n458), .A2(n332), .B1(n1387), .Q(\thePAT/n787 ) );
  OAI21X3_HV U1479 ( .A1(n458), .A2(n331), .B1(n1385), .Q(\thePAT/n785 ) );
  OAI21X3_HV U1480 ( .A1(n458), .A2(n335), .B1(n1393), .Q(\thePAT/n793 ) );
  OAI21X3_HV U1481 ( .A1(n458), .A2(n333), .B1(n1389), .Q(\thePAT/n789 ) );
  OAI21X3_HV U1482 ( .A1(n458), .A2(n334), .B1(n1391), .Q(\thePAT/n791 ) );
  NAND2X3_HV U1483 ( .A(n297), .B(n327), .Q(n1450) );
  NAND2X3_HV U1484 ( .A(\thePAT/opcode_i8[1] ), .B(\thePAT/opcode_i3[1] ), .Q(
        n801) );
  NAND4X3_HV U1485 ( .A(\thePAT/opcode_i8[3] ), .B(\thePAT/opcode_i3[3] ), .C(
        \thePAT/opcode_i3[0] ), .D(\thePAT/opcode_i3[2] ), .Q(n803) );
  NAND2X3_HV U1486 ( .A(n1454), .B(n1453), .Q(n1479) );
  CLKINVX2_HV U1487 ( .A(\thePAT/add_x_23/n56 ), .Q(\thePAT/add_x_23/n55 ) );
  OAI21X3_HV U1488 ( .A1(n837), .A2(n359), .B1(n835), .Q(\thePAT/n806 ) );
  OAI21X3_HV U1489 ( .A1(n837), .A2(n360), .B1(n836), .Q(\thePAT/n805 ) );
  OAI211X3_HV U1490 ( .A1(n912), .A2(n913), .B1(n911), .C1(n970), .Q(n914) );
  OAI21X3_HV U1491 ( .A1(n1203), .A2(n1204), .B1(n1320), .Q(n534) );
  NAND3X3_HV U1492 ( .A(n1363), .B(n1362), .C(n1191), .Q(n1193) );
  NOR4X3_HV U1493 ( .A(n822), .B(\thePAT/opcode_i3[2] ), .C(
        \thePAT/opcode_i3[0] ), .D(n348), .Q(\thePAT/op_shr ) );
  NAND3X3_HV U1494 ( .A(n1274), .B(n1275), .C(n1276), .Q(n1278) );
  AOI21X3_HV U1495 ( .A1(field_in[0]), .A2(n1264), .B1(n1263), .Q(n1267) );
  OAI21X3_HV U1496 ( .A1(n1261), .A2(n1260), .B1(n1259), .Q(n1262) );
  NAND3X3_HV U1497 ( .A(n444), .B(\thePAT/data_read_adr[3] ), .C(n723), .Q(
        n730) );
  NAND4X3_HV U1498 ( .A(n722), .B(n721), .C(n720), .D(n719), .Q(n723) );
  NAND3X3_HV U1499 ( .A(n1072), .B(n116), .C(n1074), .Q(n1079) );
  OAI211X3_HV U1500 ( .A1(n404), .A2(n678), .B1(n107), .C1(n675), .Q(n403) );
  NAND4X3_HV U1501 ( .A(n1046), .B(n1045), .C(n1044), .D(n1043), .Q(n1048) );
  AOI21X3_HV U1502 ( .A1(n1041), .A2(n1390), .B1(n1040), .Q(n1044) );
  OAI21X3_HV U1503 ( .A1(n1035), .A2(n318), .B1(n1034), .Q(n1038) );
  NAND3X3_HV U1504 ( .A(\C1/DATA1_3 ), .B(n1031), .C(n1030), .Q(n1051) );
  OAI21X3_HV U1505 ( .A1(n1025), .A2(n397), .B1(n1024), .Q(n1028) );
  OAI21X3_HV U1506 ( .A1(n1133), .A2(n521), .B1(field_in[1]), .Q(n339) );
  AOI22X3_HV U1507 ( .A1(n1325), .A2(n392), .B1(n616), .B2(n1348), .Q(n547) );
  NAND4X3_HV U1508 ( .A(n709), .B(n708), .C(n707), .D(n706), .Q(n710) );
  NAND4X3_HV U1509 ( .A(n756), .B(n755), .C(n754), .D(n753), .Q(n757) );
  CLKINVX2_HV U1510 ( .A(n802), .Q(n446) );
  NAND3X3_HV U1511 ( .A(n413), .B(n985), .C(n990), .Q(n412) );
  NAND3X3_HV U1512 ( .A(n981), .B(n1030), .C(\C1/DATA1_4 ), .Q(n986) );
  NAND3X3_HV U1513 ( .A(n1250), .B(n1249), .C(n1248), .Q(\thePAT/n779 ) );
  NAND3X3_HV U1514 ( .A(n1142), .B(n1141), .C(n1140), .Q(\thePAT/n775 ) );
  NAND3X3_HV U1515 ( .A(n1186), .B(n1185), .C(n1184), .Q(\thePAT/n777 ) );
  NAND3X3_HV U1516 ( .A(n1217), .B(n1216), .C(n1215), .Q(\thePAT/n774 ) );
  NAND3X3_HV U1517 ( .A(n1343), .B(n1342), .C(n1341), .Q(\thePAT/n773 ) );
  NAND3X3_HV U1518 ( .A(n1125), .B(n1124), .C(n1123), .Q(\thePAT/n778 ) );
  NAND3X3_HV U1519 ( .A(n1086), .B(n1085), .C(n1084), .Q(\thePAT/n776 ) );
  NAND2X3_HV U1520 ( .A(n654), .B(n871), .Q(n830) );
  CLKINVX2_HV U1521 ( .A(n636), .Q(n637) );
  NAND3X3_HV U1522 ( .A(n963), .B(n528), .C(n676), .Q(n964) );
  NAND3X3_HV U1523 ( .A(n960), .B(n352), .C(n959), .Q(n966) );
  NAND3X3_HV U1524 ( .A(n1197), .B(field_in[3]), .C(n1273), .Q(n476) );
  NOR3X3_HV U1525 ( .A(n1330), .B(n1329), .C(n1328), .Q(n1331) );
  NOR3X3_HV U1526 ( .A(n251), .B(field_in[7]), .C(n674), .Q(n1330) );
  CLKINVX2_HV U1527 ( .A(n285), .Q(n1303) );
  OAI21X3_HV U1528 ( .A1(\thePAT/field_alu_b[7] ), .A2(field_in[7]), .B1(n1321), .Q(n1299) );
  OA31X3_HV U1529 ( .A1(n1370), .A2(n273), .A3(n1373), .B1(n1310), .Q(n1219)
         );
  OAI21X3_HV U1530 ( .A1(n1232), .A2(n1231), .B1(n1230), .Q(n1233) );
  OA22X3_HV U1531 ( .A1(n677), .A2(n1290), .B1(n679), .B2(n1373), .Q(n307) );
  AOI21X3_HV U1532 ( .A1(n1190), .A2(n684), .B1(n380), .Q(n1362) );
  NAND3X3_HV U1533 ( .A(n1355), .B(n1353), .C(n557), .Q(n393) );
  NAND3X3_HV U1534 ( .A(n1031), .B(n1030), .C(n433), .Q(n432) );
  NAND3X3_HV U1535 ( .A(n855), .B(n675), .C(\thePAT/acc_alu_b[6] ), .Q(n856)
         );
  NAND3X3_HV U1536 ( .A(n352), .B(n959), .C(n93), .Q(n847) );
  OAI211X3_HV U1537 ( .A1(n1035), .A2(\thePAT/n74 ), .B1(n861), .C1(n860), .Q(
        n862) );
  AOI21X3_HV U1538 ( .A1(n974), .A2(n397), .B1(n1027), .Q(n850) );
  OAI21X3_HV U1539 ( .A1(\thePAT/add_x_23/n36 ), .A2(\thePAT/add_x_23/n28 ), 
        .B1(\thePAT/add_x_23/n31 ), .Q(\thePAT/add_x_23/n27 ) );
  OAI21X3_HV U1540 ( .A1(\acc_out[1]_BAR ), .A2(n1035), .B1(n933), .Q(n934) );
  NAND3X3_HV U1541 ( .A(n932), .B(n1034), .C(n1000), .Q(n508) );
  OAI21X3_HV U1542 ( .A1(n1002), .A2(n665), .B1(n1033), .Q(n867) );
  NAND2X3_HV U1543 ( .A(n890), .B(n1027), .Q(n357) );
  OA22X3_HV U1544 ( .A1(field_in[4]), .A2(n1370), .B1(n1171), .B2(field_in[5]), 
        .Q(n1172) );
  OAI22X3_HV U1545 ( .A1(n1171), .A2(field_in[3]), .B1(n1231), .B2(field_in[1]), .Q(n1157) );
  NAND3X3_HV U1546 ( .A(n1155), .B(n1154), .C(n1153), .Q(n1169) );
  NOR3X3_HV U1547 ( .A(n1370), .B(n248), .C(n1218), .Q(n1152) );
  NAND3X3_HV U1548 ( .A(n683), .B(field_in[2]), .C(n1143), .Q(n1144) );
  NAND3X3_HV U1549 ( .A(n342), .B(n1095), .C(\thePAT/op_sub_subm_regd_2 ), .Q(
        n1087) );
  NOR2X3_HV U1550 ( .A(\iBuffer/jump_bubble[1] ), .B(reset), .Q(n1478) );
  CLKBUFX2_HV U1551 ( .A(\thePAT/add_x_23/n54 ), .Q(n626) );
  XNOR2X2_HV U1552 ( .A(\thePAT/add_x_23/n32 ), .B(\thePAT/add_x_23/n4 ), .Q(
        n620) );
  NAND2X6_HV U1553 ( .A(\thePAT/opcode_i8[3] ), .B(\thePAT/opcode_i8[1] ), .Q(
        n820) );
  INVXL_HV U1554 ( .A(\iBuffer/imem_out[33] ), .Q(n1488) );
  INVXL_HV U1555 ( .A(\iBuffer/imem_out[34] ), .Q(n1484) );
  INVXL_HV U1556 ( .A(\iBuffer/imem_out[3] ), .Q(n1473) );
  INVXL_HV U1557 ( .A(\iBuffer/imem_out[30] ), .Q(n1493) );
  INVXL_HV U1558 ( .A(\iBuffer/imem_out[5] ), .Q(n1471) );
  INVXL_HV U1559 ( .A(\iBuffer/imem_out[7] ), .Q(n1469) );
  INVXL_HV U1560 ( .A(\iBuffer/imem_out[31] ), .Q(n1491) );
  INVXL_HV U1561 ( .A(\iBuffer/imem_out[32] ), .Q(n1490) );
  INVXL_HV U1562 ( .A(\iBuffer/imem_out[1] ), .Q(n1475) );
  INVXL_HV U1563 ( .A(\iBuffer/imem_out[11] ), .Q(n1465) );
  INVXL_HV U1564 ( .A(\iBuffer/imem_out[13] ), .Q(n1463) );
  INVXL_HV U1565 ( .A(\iBuffer/imem_out[4] ), .Q(n1472) );
  INVXL_HV U1566 ( .A(\iBuffer/imem_out[35] ), .Q(n1483) );
  INVXL_HV U1567 ( .A(\iBuffer/imem_out[37] ), .Q(n1481) );
  INVXL_HV U1568 ( .A(\iBuffer/imem_out[38] ), .Q(n1480) );
  INVXL_HV U1569 ( .A(\iBuffer/imem_out[39] ), .Q(n1477) );
  INVXL_HV U1570 ( .A(\iBuffer/imem_out[9] ), .Q(n1467) );
  INVXL_HV U1571 ( .A(\iBuffer/imem_out[0] ), .Q(n1476) );
  INVXL_HV U1572 ( .A(\iBuffer/imem_out[15] ), .Q(n1461) );
  INVXL_HV U1573 ( .A(\iBuffer/imem_out[2] ), .Q(n1474) );
  INVXL_HV U1574 ( .A(\iBuffer/imem_out[17] ), .Q(n1459) );
  INVXL_HV U1575 ( .A(\iBuffer/imem_out[36] ), .Q(n1482) );
  IMUX2XL_HV U1576 ( .A(n1499), .B(n1536), .S(n160), .Q(\iBuffer/n8 ) );
  INVXL_HV U1577 ( .A(\iBuffer/imem_out[27] ), .Q(n1499) );
  IMUX2XL_HV U1578 ( .A(n1460), .B(n1565), .S(n160), .Q(\iBuffer/n37 ) );
  INVXL_HV U1579 ( .A(\iBuffer/imem_out[16] ), .Q(n1460) );
  IMUX2XL_HV U1580 ( .A(n1510), .B(n1530), .S(n160), .Q(\iBuffer/n2 ) );
  INVXL_HV U1581 ( .A(\iBuffer/imem_out[21] ), .Q(n1510) );
  IMUX2XL_HV U1582 ( .A(n1458), .B(n1567), .S(n160), .Q(\iBuffer/n39 ) );
  INVXL_HV U1583 ( .A(\iBuffer/imem_out[18] ), .Q(n1458) );
  IMUX2XL_HV U1584 ( .A(n1457), .B(n1568), .S(n160), .Q(\iBuffer/n40 ) );
  INVXL_HV U1585 ( .A(\iBuffer/imem_out[19] ), .Q(n1457) );
  IMUX2XL_HV U1586 ( .A(n1464), .B(n1561), .S(n160), .Q(\iBuffer/n33 ) );
  INVXL_HV U1587 ( .A(\iBuffer/imem_out[12] ), .Q(n1464) );
  IMUX2XL_HV U1588 ( .A(n1495), .B(n1538), .S(n160), .Q(\iBuffer/n10 ) );
  INVXL_HV U1589 ( .A(\iBuffer/imem_out[29] ), .Q(n1495) );
  IMUX2XL_HV U1590 ( .A(n1513), .B(n1529), .S(n160), .Q(\iBuffer/n1 ) );
  INVXL_HV U1591 ( .A(\iBuffer/imem_out[20] ), .Q(n1513) );
  IMUX2XL_HV U1592 ( .A(n1507), .B(n1532), .S(n160), .Q(\iBuffer/n4 ) );
  INVXL_HV U1593 ( .A(\iBuffer/imem_out[23] ), .Q(n1507) );
  IMUX2XL_HV U1594 ( .A(n1508), .B(n1531), .S(n160), .Q(\iBuffer/n3 ) );
  INVXL_HV U1595 ( .A(\iBuffer/imem_out[22] ), .Q(n1508) );
  IMUX2XL_HV U1596 ( .A(n1503), .B(n1534), .S(n160), .Q(\iBuffer/n6 ) );
  INVXL_HV U1597 ( .A(\iBuffer/imem_out[25] ), .Q(n1503) );
  IMUX2XL_HV U1598 ( .A(n1505), .B(n1533), .S(n160), .Q(\iBuffer/n5 ) );
  INVXL_HV U1599 ( .A(\iBuffer/imem_out[24] ), .Q(n1505) );
  IMUX2XL_HV U1600 ( .A(n1501), .B(n1535), .S(n160), .Q(\iBuffer/n7 ) );
  INVXL_HV U1601 ( .A(\iBuffer/imem_out[26] ), .Q(n1501) );
  IMUX2XL_HV U1602 ( .A(n1497), .B(n1537), .S(n160), .Q(\iBuffer/n9 ) );
  INVXL_HV U1603 ( .A(\iBuffer/imem_out[28] ), .Q(n1497) );
  IMUX2XL_HV U1604 ( .A(n1462), .B(n1563), .S(n160), .Q(\iBuffer/n35 ) );
  INVXL_HV U1605 ( .A(\iBuffer/imem_out[14] ), .Q(n1462) );
  IMUX2XL_HV U1606 ( .A(n1466), .B(n1559), .S(n160), .Q(\iBuffer/n31 ) );
  INVXL_HV U1607 ( .A(\iBuffer/imem_out[10] ), .Q(n1466) );
  IMUX2XL_HV U1608 ( .A(n1470), .B(n1555), .S(n160), .Q(\iBuffer/n27 ) );
  INVXL_HV U1609 ( .A(\iBuffer/imem_out[6] ), .Q(n1470) );
  IMUX2XL_HV U1610 ( .A(n1468), .B(n1557), .S(n160), .Q(\iBuffer/n29 ) );
  INVXL_HV U1611 ( .A(\iBuffer/imem_out[8] ), .Q(n1468) );
  OA21X2_HV U1612 ( .A1(n813), .A2(n325), .B1(n806), .Q(n807) );
  NAND2XL_HV U1613 ( .A(\iBuffer/jump_bubble[0] ), .B(\iBuffer/jump_bubble[1] ), .Q(n1455) );
  MUX2X3_HV U1614 ( .A(n306), .B(\thePAT/immediate_regd_2[3] ), .S(n228), .Q(
        \thePAT/n801 ) );
  MUX2X3_HV U1615 ( .A(\thePAT/data_write_adr[7] ), .B(
        \thePAT/immediate_regd_2[7] ), .S(n228), .Q(\thePAT/n797 ) );
  MUX2X3_HV U1616 ( .A(n336), .B(\thePAT/immediate_regd_2[1] ), .S(n228), .Q(
        \thePAT/n803 ) );
  AND2X3_HV U1617 ( .A(n1485), .B(n1479), .Q(n1456) );
  MUX2X3_HV U1618 ( .A(\thePAT/dmem/dmem[14][5] ), .B(n691), .S(n1396), .Q(
        \thePAT/n750 ) );
  MUX2X3_HV U1619 ( .A(\thePAT/dmem/dmem[14][4] ), .B(n689), .S(n1396), .Q(
        \thePAT/n751 ) );
  MUX2X3_HV U1620 ( .A(\thePAT/dmem/dmem[14][3] ), .B(n687), .S(n1396), .Q(
        \thePAT/n752 ) );
  MUX2X3_HV U1621 ( .A(\thePAT/dmem/dmem[14][2] ), .B(n690), .S(n1396), .Q(
        \thePAT/n753 ) );
  MUX2X3_HV U1622 ( .A(\thePAT/dmem/dmem[14][1] ), .B(n688), .S(n1396), .Q(
        \thePAT/n754 ) );
  MUX2X3_HV U1623 ( .A(\thePAT/dmem/dmem[14][0] ), .B(n692), .S(n1396), .Q(
        \thePAT/n755 ) );
  MUX2X3_HV U1624 ( .A(\thePAT/dmem/dmem[14][7] ), .B(n693), .S(n1396), .Q(
        \thePAT/n748 ) );
  MUX2X3_HV U1625 ( .A(\thePAT/dmem/dmem[14][6] ), .B(n694), .S(n1396), .Q(
        \thePAT/n749 ) );
  MUX2X3_HV U1626 ( .A(\thePAT/dmem/dmem[8][6] ), .B(n694), .S(n1404), .Q(
        \thePAT/n701 ) );
  MUX2X3_HV U1627 ( .A(\thePAT/dmem/dmem[8][1] ), .B(n688), .S(n1404), .Q(
        \thePAT/n706 ) );
  MUX2X3_HV U1628 ( .A(\thePAT/dmem/dmem[8][0] ), .B(n692), .S(n1404), .Q(
        \thePAT/n707 ) );
  MUX2X3_HV U1629 ( .A(\thePAT/dmem/dmem[8][3] ), .B(n687), .S(n1404), .Q(
        \thePAT/n704 ) );
  MUX2X3_HV U1630 ( .A(\thePAT/dmem/dmem[8][4] ), .B(n689), .S(n1404), .Q(
        \thePAT/n703 ) );
  MUX2X3_HV U1631 ( .A(\thePAT/dmem/dmem[8][5] ), .B(n691), .S(n1404), .Q(
        \thePAT/n702 ) );
  MUX2X3_HV U1632 ( .A(\thePAT/dmem/dmem[8][2] ), .B(n690), .S(n1404), .Q(
        \thePAT/n705 ) );
  MUX2X3_HV U1633 ( .A(\thePAT/dmem/dmem[8][7] ), .B(n693), .S(n1404), .Q(
        \thePAT/n700 ) );
  MUX2X3_HV U1634 ( .A(\thePAT/dmem/dmem[10][4] ), .B(n689), .S(n1400), .Q(
        \thePAT/n719 ) );
  MUX2X3_HV U1635 ( .A(\thePAT/dmem/dmem[10][0] ), .B(n692), .S(n1400), .Q(
        \thePAT/n723 ) );
  MUX2X3_HV U1636 ( .A(\thePAT/dmem/dmem[10][1] ), .B(n688), .S(n1400), .Q(
        \thePAT/n722 ) );
  MUX2X3_HV U1637 ( .A(\thePAT/dmem/dmem[10][2] ), .B(n690), .S(n1400), .Q(
        \thePAT/n721 ) );
  MUX2X3_HV U1638 ( .A(\thePAT/dmem/dmem[10][3] ), .B(n687), .S(n1400), .Q(
        \thePAT/n720 ) );
  MUX2X3_HV U1639 ( .A(\thePAT/dmem/dmem[10][5] ), .B(n691), .S(n1400), .Q(
        \thePAT/n718 ) );
  MUX2X3_HV U1640 ( .A(\thePAT/dmem/dmem[10][6] ), .B(n694), .S(n1400), .Q(
        \thePAT/n717 ) );
  MUX2X3_HV U1641 ( .A(\thePAT/dmem/dmem[12][1] ), .B(n688), .S(n1398), .Q(
        \thePAT/n738 ) );
  MUX2X3_HV U1642 ( .A(\thePAT/dmem/dmem[10][7] ), .B(n693), .S(n1400), .Q(
        \thePAT/n716 ) );
  MUX2X3_HV U1643 ( .A(\thePAT/dmem/dmem[12][4] ), .B(n689), .S(n1398), .Q(
        \thePAT/n735 ) );
  MUX2X3_HV U1644 ( .A(\thePAT/dmem/dmem[12][6] ), .B(n694), .S(n1398), .Q(
        \thePAT/n733 ) );
  MUX2X3_HV U1645 ( .A(\thePAT/dmem/dmem[12][2] ), .B(n690), .S(n1398), .Q(
        \thePAT/n737 ) );
  MUX2X3_HV U1646 ( .A(\thePAT/dmem/dmem[12][0] ), .B(n692), .S(n1398), .Q(
        \thePAT/n739 ) );
  MUX2X3_HV U1647 ( .A(\thePAT/dmem/dmem[12][5] ), .B(n691), .S(n1398), .Q(
        \thePAT/n734 ) );
  MUX2X3_HV U1648 ( .A(\thePAT/dmem/dmem[12][3] ), .B(n687), .S(n1398), .Q(
        \thePAT/n736 ) );
  MUX2X3_HV U1649 ( .A(\thePAT/dmem/dmem[12][7] ), .B(n693), .S(n1398), .Q(
        \thePAT/n732 ) );
  XNOR2X2_HV U1650 ( .A(n631), .B(n628), .Q(\thePAT/thePC/pcInc[1] ) );
  MUX2X3_HV U1651 ( .A(\thePAT/z1 ), .B(n1247), .S(n1246), .Q(\thePAT/n781 )
         );
  MUX2X3_HV U1652 ( .A(acc_out[7]), .B(\thePAT/field_value[7] ), .S(
        \thePAT/field_op_regd ), .Q(n827) );
  MUX2X3_HV U1653 ( .A(\thePAT/dmem/dmem[13][6] ), .B(n694), .S(n1397), .Q(
        \thePAT/n741 ) );
  MUX2X3_HV U1654 ( .A(\thePAT/dmem/dmem[13][5] ), .B(n691), .S(n1397), .Q(
        \thePAT/n742 ) );
  MUX2X3_HV U1655 ( .A(\thePAT/dmem/dmem[13][2] ), .B(n690), .S(n1397), .Q(
        \thePAT/n745 ) );
  MUX2X3_HV U1656 ( .A(\thePAT/dmem/dmem[13][7] ), .B(n693), .S(n1397), .Q(
        \thePAT/n740 ) );
  MUX2X3_HV U1657 ( .A(\thePAT/dmem/dmem[13][3] ), .B(n687), .S(n1397), .Q(
        \thePAT/n744 ) );
  MUX2X3_HV U1658 ( .A(\thePAT/dmem/dmem[13][0] ), .B(n692), .S(n1397), .Q(
        \thePAT/n747 ) );
  MUX2X3_HV U1659 ( .A(\thePAT/dmem/dmem[13][1] ), .B(n688), .S(n1397), .Q(
        \thePAT/n746 ) );
  MUX2X3_HV U1660 ( .A(\thePAT/dmem/dmem[13][4] ), .B(n689), .S(n1397), .Q(
        \thePAT/n743 ) );
  MUX2X3_HV U1661 ( .A(\thePAT/dmem/dmem[15][2] ), .B(n690), .S(n1395), .Q(
        \thePAT/n761 ) );
  MUX2X3_HV U1662 ( .A(\thePAT/dmem/dmem[15][4] ), .B(n689), .S(n1395), .Q(
        \thePAT/n759 ) );
  MUX2X3_HV U1663 ( .A(\thePAT/dmem/dmem[15][1] ), .B(n688), .S(n1395), .Q(
        \thePAT/n762 ) );
  MUX2X3_HV U1664 ( .A(\thePAT/dmem/dmem[15][3] ), .B(n687), .S(n1395), .Q(
        \thePAT/n760 ) );
  MUX2X3_HV U1665 ( .A(\thePAT/dmem/dmem[15][5] ), .B(n691), .S(n1395), .Q(
        \thePAT/n758 ) );
  MUX2X3_HV U1666 ( .A(\thePAT/dmem/dmem[15][6] ), .B(n694), .S(n1395), .Q(
        \thePAT/n757 ) );
  MUX2X3_HV U1667 ( .A(\thePAT/dmem/dmem[15][7] ), .B(n693), .S(n1395), .Q(
        \thePAT/n756 ) );
  MUX2X3_HV U1668 ( .A(\thePAT/dmem/dmem[15][0] ), .B(n692), .S(n1395), .Q(
        \thePAT/n763 ) );
  MUX2X3_HV U1669 ( .A(\thePAT/dmem/dmem[11][2] ), .B(n690), .S(n1399), .Q(
        \thePAT/n729 ) );
  MUX2X3_HV U1670 ( .A(\thePAT/dmem/dmem[11][5] ), .B(n691), .S(n1399), .Q(
        \thePAT/n726 ) );
  MUX2X3_HV U1671 ( .A(\thePAT/dmem/dmem[11][3] ), .B(n687), .S(n1399), .Q(
        \thePAT/n728 ) );
  MUX2X3_HV U1672 ( .A(\thePAT/dmem/dmem[11][7] ), .B(n693), .S(n1399), .Q(
        \thePAT/n724 ) );
  MUX2X3_HV U1673 ( .A(\thePAT/dmem/dmem[11][6] ), .B(n694), .S(n1399), .Q(
        \thePAT/n725 ) );
  MUX2X3_HV U1674 ( .A(\thePAT/dmem/dmem[11][4] ), .B(n689), .S(n1399), .Q(
        \thePAT/n727 ) );
  MUX2X3_HV U1675 ( .A(\thePAT/dmem/dmem[11][0] ), .B(n692), .S(n1399), .Q(
        \thePAT/n731 ) );
  MUX2X3_HV U1676 ( .A(\thePAT/dmem/dmem[11][1] ), .B(n688), .S(n1399), .Q(
        \thePAT/n730 ) );
  MUX2X3_HV U1677 ( .A(\thePAT/dmem/dmem[9][5] ), .B(n691), .S(n1402), .Q(
        \thePAT/n710 ) );
  MUX2X3_HV U1678 ( .A(\thePAT/dmem/dmem[9][2] ), .B(n690), .S(n1402), .Q(
        \thePAT/n713 ) );
  MUX2X3_HV U1679 ( .A(\thePAT/dmem/dmem[9][1] ), .B(n688), .S(n1402), .Q(
        \thePAT/n714 ) );
  MUX2X3_HV U1680 ( .A(\thePAT/dmem/dmem[9][6] ), .B(n694), .S(n1402), .Q(
        \thePAT/n709 ) );
  MUX2X3_HV U1681 ( .A(\thePAT/dmem/dmem[9][4] ), .B(n689), .S(n1402), .Q(
        \thePAT/n711 ) );
  MUX2X3_HV U1682 ( .A(\thePAT/dmem/dmem[9][3] ), .B(n687), .S(n1402), .Q(
        \thePAT/n712 ) );
  MUX2X3_HV U1683 ( .A(\thePAT/dmem/dmem[9][0] ), .B(n692), .S(n1402), .Q(
        \thePAT/n715 ) );
  MUX2X3_HV U1684 ( .A(\thePAT/dmem/dmem[9][7] ), .B(n693), .S(n1402), .Q(
        \thePAT/n708 ) );
  AND2X3_HV U1685 ( .A(n823), .B(\thePAT/instruction_1[12] ), .Q(
        \thePAT/dest_field ) );
  MUX2X3_HV U1686 ( .A(\thePAT/dmem/dmem[3][4] ), .B(n689), .S(n97), .Q(
        \thePAT/n663 ) );
  MUX2X3_HV U1687 ( .A(\thePAT/dmem/dmem[3][0] ), .B(n692), .S(n97), .Q(
        \thePAT/n667 ) );
  MUX2X3_HV U1688 ( .A(\thePAT/dmem/dmem[3][2] ), .B(n690), .S(n97), .Q(
        \thePAT/n665 ) );
  MUX2X3_HV U1689 ( .A(\thePAT/dmem/dmem[3][1] ), .B(n688), .S(n97), .Q(
        \thePAT/n666 ) );
  MUX2X3_HV U1690 ( .A(\thePAT/dmem/dmem[3][7] ), .B(n693), .S(n97), .Q(
        \thePAT/n660 ) );
  MUX2X3_HV U1691 ( .A(\thePAT/dmem/dmem[3][6] ), .B(n694), .S(n97), .Q(
        \thePAT/n661 ) );
  MUX2X3_HV U1692 ( .A(\thePAT/dmem/dmem[3][5] ), .B(n691), .S(n97), .Q(
        \thePAT/n662 ) );
  MUX2X3_HV U1693 ( .A(\thePAT/dmem/dmem[3][3] ), .B(n687), .S(n97), .Q(
        \thePAT/n664 ) );
  AND2X3_HV U1694 ( .A(n823), .B(\thePAT/n17 ), .Q(\thePAT/dest_acc ) );
  NAND2XL_HV U1695 ( .A(n821), .B(n1422), .Q(n814) );
  MUX2X3_HV U1696 ( .A(\thePAT/dmem/dmem[7][0] ), .B(n692), .S(n1406), .Q(
        \thePAT/n699 ) );
  MUX2X3_HV U1697 ( .A(\thePAT/dmem/dmem[7][3] ), .B(n687), .S(n1406), .Q(
        \thePAT/n696 ) );
  MUX2X3_HV U1698 ( .A(\thePAT/dmem/dmem[7][2] ), .B(n690), .S(n1406), .Q(
        \thePAT/n697 ) );
  MUX2X3_HV U1699 ( .A(\thePAT/dmem/dmem[7][4] ), .B(n689), .S(n1406), .Q(
        \thePAT/n695 ) );
  MUX2X3_HV U1700 ( .A(\thePAT/dmem/dmem[7][6] ), .B(n694), .S(n1406), .Q(
        \thePAT/n693 ) );
  MUX2X3_HV U1701 ( .A(\thePAT/dmem/dmem[7][5] ), .B(n691), .S(n1406), .Q(
        \thePAT/n694 ) );
  MUX2X3_HV U1702 ( .A(\thePAT/dmem/dmem[7][1] ), .B(n688), .S(n1406), .Q(
        \thePAT/n698 ) );
  MUX2X3_HV U1703 ( .A(\thePAT/dmem/dmem[7][7] ), .B(n693), .S(n1406), .Q(
        \thePAT/n692 ) );
  MUX2X3_HV U1704 ( .A(\thePAT/dmem/dmem[1][5] ), .B(n691), .S(n1418), .Q(
        \thePAT/n646 ) );
  MUX2X3_HV U1705 ( .A(\thePAT/dmem/dmem[1][1] ), .B(n688), .S(n1418), .Q(
        \thePAT/n650 ) );
  MUX2X3_HV U1706 ( .A(\thePAT/dmem/dmem[1][6] ), .B(n694), .S(n1418), .Q(
        \thePAT/n645 ) );
  MUX2X3_HV U1707 ( .A(\thePAT/dmem/dmem[1][3] ), .B(n687), .S(n1418), .Q(
        \thePAT/n648 ) );
  MUX2X3_HV U1708 ( .A(\thePAT/dmem/dmem[1][2] ), .B(n690), .S(n1418), .Q(
        \thePAT/n649 ) );
  MUX2X3_HV U1709 ( .A(\thePAT/dmem/dmem[1][0] ), .B(n692), .S(n1418), .Q(
        \thePAT/n651 ) );
  MUX2X3_HV U1710 ( .A(\thePAT/dmem/dmem[1][4] ), .B(n689), .S(n1418), .Q(
        \thePAT/n647 ) );
  MUX2X3_HV U1711 ( .A(\thePAT/dmem/dmem[1][7] ), .B(n693), .S(n1418), .Q(
        \thePAT/n644 ) );
  MUX2X3_HV U1712 ( .A(outputs[6]), .B(n108), .S(n680), .Q(\thePAT/n780 ) );
  MUX2X3_HV U1713 ( .A(outputs[7]), .B(acc_out[7]), .S(n680), .Q(\thePAT/n795 ) );
  MUX2X3_HV U1714 ( .A(\thePAT/dmem/dmem[4][2] ), .B(n690), .S(n1413), .Q(
        \thePAT/n673 ) );
  MUX2X3_HV U1715 ( .A(\thePAT/dmem/dmem[4][3] ), .B(n687), .S(n1413), .Q(
        \thePAT/n672 ) );
  MUX2X3_HV U1716 ( .A(\thePAT/dmem/dmem[4][4] ), .B(n689), .S(n1413), .Q(
        \thePAT/n671 ) );
  MUX2X3_HV U1717 ( .A(\thePAT/dmem/dmem[4][5] ), .B(n691), .S(n1413), .Q(
        \thePAT/n670 ) );
  MUX2X3_HV U1718 ( .A(\thePAT/dmem/dmem[6][0] ), .B(n692), .S(n1410), .Q(
        \thePAT/n691 ) );
  MUX2X3_HV U1719 ( .A(\thePAT/dmem/dmem[2][6] ), .B(n694), .S(n1416), .Q(
        \thePAT/n653 ) );
  MUX2X3_HV U1720 ( .A(\thePAT/dmem/dmem[6][1] ), .B(n688), .S(n1410), .Q(
        \thePAT/n690 ) );
  MUX2X3_HV U1721 ( .A(\thePAT/dmem/dmem[2][1] ), .B(n688), .S(n1416), .Q(
        \thePAT/n658 ) );
  MUX2X3_HV U1722 ( .A(\thePAT/dmem/dmem[6][2] ), .B(n690), .S(n1410), .Q(
        \thePAT/n689 ) );
  MUX2X3_HV U1723 ( .A(\thePAT/dmem/dmem[2][0] ), .B(n692), .S(n1416), .Q(
        \thePAT/n659 ) );
  MUX2X3_HV U1724 ( .A(\thePAT/dmem/dmem[6][3] ), .B(n687), .S(n1410), .Q(
        \thePAT/n688 ) );
  MUX2X3_HV U1725 ( .A(\thePAT/dmem/dmem[6][4] ), .B(n689), .S(n1410), .Q(
        \thePAT/n687 ) );
  MUX2X3_HV U1726 ( .A(\thePAT/dmem/dmem[6][5] ), .B(n691), .S(n1410), .Q(
        \thePAT/n686 ) );
  MUX2X3_HV U1727 ( .A(\thePAT/dmem/dmem[6][6] ), .B(n694), .S(n1410), .Q(
        \thePAT/n685 ) );
  MUX2X3_HV U1728 ( .A(\thePAT/dmem/dmem[6][7] ), .B(n693), .S(n1410), .Q(
        \thePAT/n684 ) );
  MUX2X3_HV U1729 ( .A(\thePAT/dmem/dmem[0][4] ), .B(n689), .S(n1421), .Q(
        \thePAT/n639 ) );
  MUX2X3_HV U1730 ( .A(\thePAT/dmem/dmem[4][1] ), .B(n688), .S(n1413), .Q(
        \thePAT/n674 ) );
  MUX2X3_HV U1731 ( .A(\thePAT/dmem/dmem[0][3] ), .B(n687), .S(n1421), .Q(
        \thePAT/n640 ) );
  MUX2X3_HV U1732 ( .A(\thePAT/dmem/dmem[0][2] ), .B(n690), .S(n1421), .Q(
        \thePAT/n641 ) );
  MUX2X3_HV U1733 ( .A(\thePAT/dmem/dmem[0][1] ), .B(n688), .S(n1421), .Q(
        \thePAT/n642 ) );
  MUX2X3_HV U1734 ( .A(\thePAT/dmem/dmem[0][0] ), .B(n692), .S(n1421), .Q(
        \thePAT/n643 ) );
  MUX2X3_HV U1735 ( .A(\thePAT/dmem/dmem[2][7] ), .B(n693), .S(n1416), .Q(
        \thePAT/n652 ) );
  MUX2X3_HV U1736 ( .A(\thePAT/dmem/dmem[4][6] ), .B(n694), .S(n1413), .Q(
        \thePAT/n669 ) );
  MUX2X3_HV U1737 ( .A(\thePAT/dmem/dmem[2][4] ), .B(n689), .S(n1416), .Q(
        \thePAT/n655 ) );
  MUX2X3_HV U1738 ( .A(\thePAT/dmem/dmem[4][7] ), .B(n693), .S(n1413), .Q(
        \thePAT/n668 ) );
  MUX2X3_HV U1739 ( .A(\thePAT/dmem/dmem[2][5] ), .B(n691), .S(n1416), .Q(
        \thePAT/n654 ) );
  MUX2X3_HV U1740 ( .A(\thePAT/dmem/dmem[4][0] ), .B(n692), .S(n1413), .Q(
        \thePAT/n675 ) );
  MUX2X3_HV U1741 ( .A(\thePAT/dmem/dmem[2][3] ), .B(n687), .S(n1416), .Q(
        \thePAT/n656 ) );
  MUX2X3_HV U1742 ( .A(\thePAT/dmem/dmem[0][7] ), .B(n693), .S(n1421), .Q(
        \thePAT/n636 ) );
  MUX2X3_HV U1743 ( .A(\thePAT/dmem/dmem[2][2] ), .B(n690), .S(n1416), .Q(
        \thePAT/n657 ) );
  MUX2X3_HV U1744 ( .A(\thePAT/dmem/dmem[0][5] ), .B(n691), .S(n1421), .Q(
        \thePAT/n638 ) );
  MUX2X3_HV U1745 ( .A(\thePAT/dmem/dmem[0][6] ), .B(n694), .S(n1421), .Q(
        \thePAT/n637 ) );
  MUX2X3_HV U1746 ( .A(\thePAT/dmem/dmem[5][3] ), .B(n687), .S(n99), .Q(
        \thePAT/n680 ) );
  MUX2X3_HV U1747 ( .A(\thePAT/dmem/dmem[5][2] ), .B(n690), .S(n99), .Q(
        \thePAT/n681 ) );
  MUX2X3_HV U1748 ( .A(\thePAT/dmem/dmem[5][0] ), .B(n692), .S(n99), .Q(
        \thePAT/n683 ) );
  MUX2X3_HV U1749 ( .A(\thePAT/dmem/dmem[5][4] ), .B(n689), .S(n99), .Q(
        \thePAT/n679 ) );
  MUX2X3_HV U1750 ( .A(\thePAT/dmem/dmem[5][5] ), .B(n691), .S(n99), .Q(
        \thePAT/n678 ) );
  MUX2X3_HV U1751 ( .A(\thePAT/dmem/dmem[5][1] ), .B(n688), .S(n99), .Q(
        \thePAT/n682 ) );
  MUX2X3_HV U1752 ( .A(\thePAT/dmem/dmem[5][7] ), .B(n693), .S(n99), .Q(
        \thePAT/n676 ) );
  MUX2X3_HV U1753 ( .A(\thePAT/dmem/dmem[5][6] ), .B(n694), .S(n99), .Q(
        \thePAT/n677 ) );
  AO22X3_HV U1754 ( .A1(n1512), .A2(\iBuffer/i_buffer[0][1] ), .B1(n1511), 
        .B2(\iBuffer/i_buffer[1][1] ), .Q(\iBuffer/N32 ) );
  AO22X3_HV U1755 ( .A1(n1512), .A2(\iBuffer/i_buffer[0][12] ), .B1(n1511), 
        .B2(\iBuffer/i_buffer[1][12] ), .Q(\iBuffer/N43 ) );
  AO22X3_HV U1756 ( .A1(n1512), .A2(\iBuffer/i_buffer[0][18] ), .B1(n1511), 
        .B2(\iBuffer/i_buffer[1][18] ), .Q(\iBuffer/N49 ) );
  AO22X3_HV U1757 ( .A1(n1512), .A2(\iBuffer/i_buffer[0][19] ), .B1(n1511), 
        .B2(\iBuffer/i_buffer[1][19] ), .Q(\iBuffer/N50 ) );
  AO22X3_HV U1758 ( .A1(n1512), .A2(\iBuffer/i_buffer[0][17] ), .B1(n1511), 
        .B2(\iBuffer/i_buffer[1][17] ), .Q(\iBuffer/N48 ) );
  AO22X3_HV U1759 ( .A1(n1512), .A2(\iBuffer/i_buffer[0][15] ), .B1(n1511), 
        .B2(\iBuffer/i_buffer[1][15] ), .Q(\iBuffer/N46 ) );
  AO22X3_HV U1760 ( .A1(n1512), .A2(\iBuffer/i_buffer[0][3] ), .B1(n1511), 
        .B2(\iBuffer/i_buffer[1][3] ), .Q(\iBuffer/N34 ) );
  AO22X3_HV U1761 ( .A1(n1512), .A2(\iBuffer/i_buffer[0][16] ), .B1(n1511), 
        .B2(\iBuffer/i_buffer[1][16] ), .Q(\iBuffer/N47 ) );
  NAND2XL_HV U1762 ( .A(n637), .B(\thePAT/thePC/pc[9] ), .Q(
        \thePAT/add_x_23/n12 ) );
  OR2X3_HV U1763 ( .A(n637), .B(\thePAT/thePC/pc[9] ), .Q(n370) );
  AO22X3_HV U1764 ( .A1(n990), .A2(n891), .B1(n1030), .B2(n376), .Q(n308) );
  NAND2XL_HV U1765 ( .A(n1357), .B(n273), .Q(n1202) );
  OR2X3_HV U1766 ( .A(\DP_OP_108_135_5866/n52 ), .B(field_in[2]), .Q(n638) );
  AND2X3_HV U1767 ( .A(n800), .B(n316), .Q(n812) );
  INVXL_HV U1768 ( .A(inputs[0]), .Q(n894) );
  NAND2XL_HV U1769 ( .A(n678), .B(n85), .Q(n1255) );
  INVXL_HV U1770 ( .A(n459), .Q(n831) );
  AND2X3_HV U1771 ( .A(n1069), .B(n1068), .Q(n1071) );
  OR2X3_HV U1772 ( .A(n1042), .B(\acc_out[0]_BAR ), .Q(n1043) );
  NAND3X1_HV U1773 ( .A(n992), .B(n991), .C(n1095), .Q(n1007) );
  OR2X3_HV U1774 ( .A(n616), .B(n1390), .Q(n609) );
  OR2X3_HV U1775 ( .A(n1009), .B(n520), .Q(n1010) );
  OR2X3_HV U1776 ( .A(\acc_out[1]_BAR ), .B(n646), .Q(n400) );
  OR2X3_HV U1777 ( .A(n1022), .B(n1021), .Q(n1132) );
  INVXL_HV U1778 ( .A(inputs[1]), .Q(n1021) );
  XNOR2X2_HV U1779 ( .A(\thePAT/add_x_23/n46 ), .B(\thePAT/add_x_23/n6 ), .Q(
        \thePAT/thePC/pcAdd[4] ) );
  NAND2XL_HV U1780 ( .A(n1340), .B(n693), .Q(n1283) );
  XNOR2X2_HV U1781 ( .A(n244), .B(\DP_OP_104_132_4164/n5 ), .Q(\C1/DATA1_4 )
         );
  AND2X3_HV U1782 ( .A(\thePAT/field_value[4] ), .B(n634), .Q(n529) );
  NAND2XL_HV U1783 ( .A(n1340), .B(n692), .Q(n1248) );
  NAND2XL_HV U1784 ( .A(n1340), .B(n689), .Q(n1140) );
  NAND2XL_HV U1785 ( .A(n1340), .B(n690), .Q(n1184) );
  NAND2XL_HV U1786 ( .A(n1340), .B(n691), .Q(n1215) );
  NAND2XL_HV U1787 ( .A(n1340), .B(n694), .Q(n1341) );
  NAND2XL_HV U1788 ( .A(n1340), .B(n688), .Q(n1123) );
  NAND2XL_HV U1789 ( .A(n1340), .B(n687), .Q(n1084) );
  XNOR2X2_HV U1790 ( .A(\thePAT/add_x_23/n18 ), .B(\thePAT/add_x_23/n2 ), .Q(
        \thePAT/thePC/pcAdd[8] ) );
  OR2X3_HV U1791 ( .A(n637), .B(\thePAT/thePC/pc[8] ), .Q(n302) );
  NAND2XL_HV U1792 ( .A(n1143), .B(n1145), .Q(n1093) );
  INVXL_HV U1793 ( .A(n1291), .Q(n1236) );
  OR2X3_HV U1794 ( .A(n659), .B(field_in[6]), .Q(n371) );
  AND2X3_HV U1795 ( .A(\DP_OP_108_135_5866/n67 ), .B(n1348), .Q(n380) );
  OR2X3_HV U1796 ( .A(n1370), .B(field_in[2]), .Q(n1363) );
  OR2X3_HV U1797 ( .A(\DP_OP_108_135_5866/n67 ), .B(field_in[0]), .Q(n1345) );
  INVXL_HV U1798 ( .A(field_in[7]), .Q(n1327) );
  NAND2XL_HV U1799 ( .A(n678), .B(\thePAT/field_alu_b[6] ), .Q(n1353) );
  INVXL_HV U1800 ( .A(inputs[5]), .Q(n926) );
  OR2X3_HV U1801 ( .A(n616), .B(acc_out[7]), .Q(n382) );
  INVXL_HV U1802 ( .A(inputs[7]), .Q(n889) );
  OA21X2_HV U1803 ( .A1(n104), .A2(\thePAT/n75 ), .B1(n106), .Q(n887) );
  AND2X3_HV U1804 ( .A(n347), .B(\DP_OP_104_132_4164/n11 ), .Q(n387) );
  AND3X2_HV U1805 ( .A(n990), .B(n695), .C(n619), .Q(n361) );
  INVXL_HV U1806 ( .A(inputs[4]), .Q(n977) );
  NAND2XL_HV U1807 ( .A(n14), .B(\thePAT/op_mov_regd ), .Q(n1164) );
  NAND2XL_HV U1808 ( .A(n1286), .B(n1291), .Q(n1146) );
  AND2X3_HV U1809 ( .A(\DP_OP_108_135_5866/n43 ), .B(\DP_OP_108_135_5866/n27 ), 
        .Q(n386) );
  OR2X3_HV U1810 ( .A(n839), .B(n646), .Q(n343) );
  OR2X3_HV U1811 ( .A(n628), .B(\thePAT/pc_immediate[0] ), .Q(n349) );
  OR2X3_HV U1812 ( .A(n104), .B(acc_out[0]), .Q(n358) );
  AND2X3_HV U1813 ( .A(n358), .B(n274), .Q(n376) );
  AND2X3_HV U1814 ( .A(n814), .B(n813), .Q(n383) );
  OR2X3_HV U1815 ( .A(n324), .B(field_in[7]), .Q(n385) );
  AND2X3_HV U1816 ( .A(\thePAT/field_alu_b[6] ), .B(field_in[6]), .Q(n388) );
  INVXL_HV U1817 ( .A(field_in[5]), .Q(n1373) );
  INVXL_HV U1818 ( .A(field_in[6]), .Q(n1369) );
  XNOR2X2_HV U1819 ( .A(n984), .B(n983), .Q(n413) );
  XNOR2X2_HV U1820 ( .A(\thePAT/add_x_22/n24 ), .B(n630), .Q(
        \thePAT/thePC/pcInc[4] ) );
  XNOR2X2_HV U1821 ( .A(n434), .B(\DP_OP_104_132_4164/n3 ), .Q(n433) );
  XNOR2X2_HV U1822 ( .A(\DP_OP_104_132_4164/n12 ), .B(n387), .Q(n464) );
  XNOR2X2_HV U1823 ( .A(n495), .B(n1381), .Q(n494) );
  XNOR2X2_HV U1824 ( .A(n497), .B(\DP_OP_108_135_5866/n3 ), .Q(n496) );
  XNOR2X2_HV U1825 ( .A(n129), .B(n540), .Q(n539) );
  XNOR2X2_HV U1826 ( .A(\DP_OP_108_135_5866/n1 ), .B(n386), .Q(n1519) );
  XNOR2X2_HV U1827 ( .A(\DP_OP_104_132_4164/n8 ), .B(n274), .Q(n599) );
  XNOR2X2_HV U1828 ( .A(n989), .B(n272), .Q(n601) );
  LOGIC0_HV U1829 ( .Q(n1528) );
  MUX2X3_HV U1830 ( .A(\thePAT/data_write_adr[4] ), .B(
        \thePAT/immediate_regd_2[4] ), .S(n228), .Q(\thePAT/n800 ) );
  MUX2X3_HV U1831 ( .A(\thePAT/data_write_adr[5] ), .B(
        \thePAT/immediate_regd_2[5] ), .S(n228), .Q(\thePAT/n799 ) );
  MUX2X3_HV U1832 ( .A(\thePAT/data_write_adr[6] ), .B(
        \thePAT/immediate_regd_2[6] ), .S(n228), .Q(\thePAT/n798 ) );
  OR2X3_HV U1833 ( .A(\thePAT/pc_immediate[3] ), .B(\thePAT/thePC/pc[3] ), .Q(
        n624) );
  MUX2X3_HV U1834 ( .A(n354), .B(\thePAT/immediate_regd_2[0] ), .S(n228), .Q(
        \thePAT/n804 ) );
  MUX2X3_HV U1835 ( .A(n321), .B(\thePAT/immediate_regd_2[2] ), .S(n228), .Q(
        \thePAT/n802 ) );
  XOR2X1_HV U1836 ( .A(acc_out[0]), .B(n159), .Q(n891) );
  XNOR2X2_HV U1837 ( .A(n1094), .B(n1093), .Q(n1098) );
  XNOR2X2_HV U1838 ( .A(n1126), .B(n1251), .Q(n1127) );
  XNOR2X2_HV U1839 ( .A(n1379), .B(n1146), .Q(n1147) );
  XNOR2X2_HV U1840 ( .A(n1207), .B(n1208), .Q(n1209) );
endmodule


module pads ( clk, pad_clock, pad_sclk, pad_reset, pad_modesel_0, 
        pad_modesel_1, pad_io_a0, pad_io_a1, pad_io_a2, pad_io_a3, pad_io_a4, 
        pad_io_a5, pad_io_a6, pad_io_a7, pad_io_b0, pad_io_b1, pad_io_b2, 
        pad_io_b3, pad_io_b4, pad_io_b5, pad_io_b6, pad_io_b7 );
  input clk;
  inout pad_clock,  pad_sclk,  pad_reset,  pad_modesel_0,  pad_modesel_1, 
     pad_io_a0,  pad_io_a1,  pad_io_a2,  pad_io_a3,  pad_io_a4,  pad_io_a5, 
     pad_io_a6,  pad_io_a7,  pad_io_b0,  pad_io_b1,  pad_io_b2,  pad_io_b3, 
     pad_io_b4,  pad_io_b5,  pad_io_b6,  pad_io_b7;
  wire   \*Logic1* , \*Logic0* , reset, modesel_1, n1, n2, n3;
  wire   [7:0] inputs_a;
  wire   [7:0] acc_out;
  wire   [7:0] outputs;
  tri   pad_clock;
  tri   pad_sclk;
  tri   pad_reset;
  tri   pad_modesel_0;
  tri   pad_modesel_1;
  tri   pad_io_a0;
  tri   pad_io_a1;
  tri   pad_io_a2;
  tri   pad_io_a3;
  tri   pad_io_a4;
  tri   pad_io_a5;
  tri   pad_io_a6;
  tri   pad_io_a7;
  tri   pad_io_b0;
  tri   pad_io_b1;
  tri   pad_io_b2;
  tri   pad_io_b3;
  tri   pad_io_b4;
  tri   pad_io_b5;
  tri   pad_io_b6;
  tri   pad_io_b7;
  tri   modesel_0;
  tri   [49:0] input_shifter;

  IOPAD1V8_3_HV iopad_clock ( .SR(\*Logic0* ), .PE(\*Logic0* ), .A(\*Logic0* ), 
        .IE(\*Logic1* ), .OE0(\*Logic0* ), .OE1(\*Logic0* ), .PAD(pad_clock)
         );
  IOPAD1V8_3_HV iopad_reset ( .SR(\*Logic0* ), .PE(\*Logic0* ), .A(\*Logic0* ), 
        .IE(\*Logic1* ), .OE0(\*Logic0* ), .OE1(\*Logic0* ), .PAD(pad_reset), 
        .Y(reset) );
  IOPAD1V8_3_HV iopad_sclk ( .SR(\*Logic0* ), .PE(\*Logic0* ), .A(\*Logic0* ), 
        .IE(\*Logic1* ), .OE0(\*Logic0* ), .OE1(\*Logic0* ), .PAD(pad_sclk) );
  IOPAD1V8_3_HV iopad_modesel_0 ( .SR(\*Logic0* ), .PE(\*Logic0* ), .A(
        \*Logic0* ), .IE(\*Logic1* ), .OE0(\*Logic0* ), .OE1(\*Logic0* ), 
        .PAD(pad_modesel_0), .Y(modesel_0) );
  IOPAD1V8_3_HV iopad_modesel_1 ( .SR(\*Logic0* ), .PE(\*Logic0* ), .A(
        \*Logic0* ), .IE(\*Logic1* ), .OE0(\*Logic0* ), .OE1(\*Logic0* ), 
        .PAD(pad_modesel_1), .Y(modesel_1) );
  IOPAD1V8_3_HV iopad_a0 ( .SR(\*Logic0* ), .PE(\*Logic0* ), .A(n1), .IE(
        \*Logic1* ), .OE0(\*Logic0* ), .OE1(\*Logic0* ), .PAD(pad_io_a0), .Y(
        inputs_a[0]) );
  IOPAD1V8_3_HV iopad_a1 ( .SR(\*Logic0* ), .PE(\*Logic0* ), .A(n2), .IE(
        \*Logic1* ), .OE0(\*Logic0* ), .OE1(\*Logic0* ), .PAD(pad_io_a1), .Y(
        inputs_a[1]) );
  IOPAD1V8_3_HV iopad_a2 ( .SR(\*Logic0* ), .PE(\*Logic0* ), .A(acc_out[2]), 
        .IE(\*Logic1* ), .OE0(\*Logic0* ), .OE1(\*Logic0* ), .PAD(pad_io_a2), 
        .Y(inputs_a[2]) );
  IOPAD1V8_3_HV iopad_a3 ( .SR(\*Logic0* ), .PE(\*Logic0* ), .A(acc_out[3]), 
        .IE(\*Logic1* ), .OE0(\*Logic0* ), .OE1(\*Logic0* ), .PAD(pad_io_a3), 
        .Y(inputs_a[3]) );
  IOPAD1V8_3_HV iopad_a4 ( .SR(\*Logic0* ), .PE(\*Logic0* ), .A(n3), .IE(
        \*Logic1* ), .OE0(\*Logic0* ), .OE1(\*Logic0* ), .PAD(pad_io_a4), .Y(
        inputs_a[4]) );
  IOPAD1V8_3_HV iopad_a5 ( .SR(\*Logic0* ), .PE(\*Logic0* ), .A(acc_out[5]), 
        .IE(\*Logic1* ), .OE0(\*Logic0* ), .OE1(\*Logic0* ), .PAD(pad_io_a5), 
        .Y(inputs_a[5]) );
  IOPAD1V8_3_HV iopad_a6 ( .SR(\*Logic0* ), .PE(\*Logic0* ), .A(acc_out[6]), 
        .IE(\*Logic1* ), .OE0(\*Logic0* ), .OE1(\*Logic0* ), .PAD(pad_io_a6), 
        .Y(inputs_a[6]) );
  IOPAD1V8_3_HV iopad_a7 ( .SR(\*Logic0* ), .PE(\*Logic0* ), .A(acc_out[7]), 
        .IE(\*Logic1* ), .OE0(\*Logic0* ), .OE1(\*Logic0* ), .PAD(pad_io_a7), 
        .Y(inputs_a[7]) );
  IOPAD1V8_3_HV iopad_b0 ( .SR(\*Logic0* ), .PE(\*Logic0* ), .A(outputs[0]), 
        .IE(\*Logic0* ), .OE0(\*Logic1* ), .OE1(\*Logic1* ), .PAD(pad_io_b0)
         );
  IOPAD1V8_3_HV iopad_b1 ( .SR(\*Logic0* ), .PE(\*Logic0* ), .A(outputs[1]), 
        .IE(\*Logic0* ), .OE0(\*Logic1* ), .OE1(\*Logic1* ), .PAD(pad_io_b1)
         );
  IOPAD1V8_3_HV iopad_b2 ( .SR(\*Logic0* ), .PE(\*Logic0* ), .A(outputs[2]), 
        .IE(\*Logic0* ), .OE0(\*Logic1* ), .OE1(\*Logic1* ), .PAD(pad_io_b2)
         );
  IOPAD1V8_3_HV iopad_b3 ( .SR(\*Logic0* ), .PE(\*Logic0* ), .A(outputs[3]), 
        .IE(\*Logic0* ), .OE0(\*Logic1* ), .OE1(\*Logic1* ), .PAD(pad_io_b3)
         );
  IOPAD1V8_3_HV iopad_b4 ( .SR(\*Logic0* ), .PE(\*Logic0* ), .A(outputs[4]), 
        .IE(\*Logic0* ), .OE0(\*Logic1* ), .OE1(\*Logic1* ), .PAD(pad_io_b4)
         );
  IOPAD1V8_3_HV iopad_b5 ( .SR(\*Logic0* ), .PE(\*Logic0* ), .A(outputs[5]), 
        .IE(\*Logic0* ), .OE0(\*Logic1* ), .OE1(\*Logic1* ), .PAD(pad_io_b5)
         );
  IOPAD1V8_3_HV iopad_b6 ( .SR(\*Logic0* ), .PE(\*Logic0* ), .A(outputs[6]), 
        .IE(\*Logic0* ), .OE0(\*Logic1* ), .OE1(\*Logic1* ), .PAD(pad_io_b6)
         );
  IOPAD1V8_3_HV iopad_b7 ( .SR(\*Logic0* ), .PE(\*Logic0* ), .A(outputs[7]), 
        .IE(\*Logic0* ), .OE0(\*Logic1* ), .OE1(\*Logic1* ), .PAD(pad_io_b7)
         );
  digital theCore ( .clk(clk), .reset(reset), .inputs(inputs_a), 
        .imem_write_adr(input_shifter[49:40]), .imem_write(modesel_0), 
        .imem_in(input_shifter[39:0]), .outputs(outputs), .\acc_out[7] (
        acc_out[7]), .\acc_out[6] (acc_out[6]), .\acc_out[5] (acc_out[5]), 
        .\acc_out[4]_BAR (acc_out[4]), .\acc_out[3] (acc_out[3]), 
        .\acc_out[2] (acc_out[2]), .\acc_out[1]_BAR (acc_out[1]), 
        .\acc_out[0]_BAR (acc_out[0]) );
  DFX2_HV \input_shifter_reg[0]  ( .D(inputs_a[0]), .CP(modesel_1), .Q(
        input_shifter[0]) );
  DFX2_HV \input_shifter_reg[8]  ( .D(input_shifter[0]), .CP(modesel_1), .Q(
        input_shifter[8]) );
  DFX2_HV \input_shifter_reg[16]  ( .D(input_shifter[8]), .CP(modesel_1), .Q(
        input_shifter[16]) );
  DFX2_HV \input_shifter_reg[24]  ( .D(input_shifter[16]), .CP(modesel_1), .Q(
        input_shifter[24]) );
  DFX2_HV \input_shifter_reg[32]  ( .D(input_shifter[24]), .CP(modesel_1), .Q(
        input_shifter[32]) );
  DFX2_HV \input_shifter_reg[40]  ( .D(input_shifter[32]), .CP(modesel_1), .Q(
        input_shifter[40]) );
  DFX2_HV \input_shifter_reg[48]  ( .D(input_shifter[40]), .CP(modesel_1), .Q(
        input_shifter[48]) );
  DFX2_HV \input_shifter_reg[1]  ( .D(inputs_a[1]), .CP(modesel_1), .Q(
        input_shifter[1]) );
  DFX2_HV \input_shifter_reg[9]  ( .D(input_shifter[1]), .CP(modesel_1), .Q(
        input_shifter[9]) );
  DFX2_HV \input_shifter_reg[17]  ( .D(input_shifter[9]), .CP(modesel_1), .Q(
        input_shifter[17]) );
  DFX2_HV \input_shifter_reg[25]  ( .D(input_shifter[17]), .CP(modesel_1), .Q(
        input_shifter[25]) );
  DFX2_HV \input_shifter_reg[33]  ( .D(input_shifter[25]), .CP(modesel_1), .Q(
        input_shifter[33]) );
  DFX2_HV \input_shifter_reg[41]  ( .D(input_shifter[33]), .CP(modesel_1), .Q(
        input_shifter[41]) );
  DFX2_HV \input_shifter_reg[49]  ( .D(input_shifter[41]), .CP(modesel_1), .Q(
        input_shifter[49]) );
  DFX2_HV \input_shifter_reg[2]  ( .D(inputs_a[2]), .CP(modesel_1), .Q(
        input_shifter[2]) );
  DFX2_HV \input_shifter_reg[10]  ( .D(input_shifter[2]), .CP(modesel_1), .Q(
        input_shifter[10]) );
  DFX2_HV \input_shifter_reg[18]  ( .D(input_shifter[10]), .CP(modesel_1), .Q(
        input_shifter[18]) );
  DFX2_HV \input_shifter_reg[26]  ( .D(input_shifter[18]), .CP(modesel_1), .Q(
        input_shifter[26]) );
  DFX2_HV \input_shifter_reg[34]  ( .D(input_shifter[26]), .CP(modesel_1), .Q(
        input_shifter[34]) );
  DFX2_HV \input_shifter_reg[42]  ( .D(input_shifter[34]), .CP(modesel_1), .Q(
        input_shifter[42]) );
  DFX2_HV \input_shifter_reg[3]  ( .D(inputs_a[3]), .CP(modesel_1), .Q(
        input_shifter[3]) );
  DFX2_HV \input_shifter_reg[11]  ( .D(input_shifter[3]), .CP(modesel_1), .Q(
        input_shifter[11]) );
  DFX2_HV \input_shifter_reg[19]  ( .D(input_shifter[11]), .CP(modesel_1), .Q(
        input_shifter[19]) );
  DFX2_HV \input_shifter_reg[27]  ( .D(input_shifter[19]), .CP(modesel_1), .Q(
        input_shifter[27]) );
  DFX2_HV \input_shifter_reg[35]  ( .D(input_shifter[27]), .CP(modesel_1), .Q(
        input_shifter[35]) );
  DFX2_HV \input_shifter_reg[43]  ( .D(input_shifter[35]), .CP(modesel_1), .Q(
        input_shifter[43]) );
  DFX2_HV \input_shifter_reg[4]  ( .D(inputs_a[4]), .CP(modesel_1), .Q(
        input_shifter[4]) );
  DFX2_HV \input_shifter_reg[12]  ( .D(input_shifter[4]), .CP(modesel_1), .Q(
        input_shifter[12]) );
  DFX2_HV \input_shifter_reg[20]  ( .D(input_shifter[12]), .CP(modesel_1), .Q(
        input_shifter[20]) );
  DFX2_HV \input_shifter_reg[28]  ( .D(input_shifter[20]), .CP(modesel_1), .Q(
        input_shifter[28]) );
  DFX2_HV \input_shifter_reg[36]  ( .D(input_shifter[28]), .CP(modesel_1), .Q(
        input_shifter[36]) );
  DFX2_HV \input_shifter_reg[44]  ( .D(input_shifter[36]), .CP(modesel_1), .Q(
        input_shifter[44]) );
  DFX2_HV \input_shifter_reg[5]  ( .D(inputs_a[5]), .CP(modesel_1), .Q(
        input_shifter[5]) );
  DFX2_HV \input_shifter_reg[13]  ( .D(input_shifter[5]), .CP(modesel_1), .Q(
        input_shifter[13]) );
  DFX2_HV \input_shifter_reg[21]  ( .D(input_shifter[13]), .CP(modesel_1), .Q(
        input_shifter[21]) );
  DFX2_HV \input_shifter_reg[29]  ( .D(input_shifter[21]), .CP(modesel_1), .Q(
        input_shifter[29]) );
  DFX2_HV \input_shifter_reg[37]  ( .D(input_shifter[29]), .CP(modesel_1), .Q(
        input_shifter[37]) );
  DFX2_HV \input_shifter_reg[45]  ( .D(input_shifter[37]), .CP(modesel_1), .Q(
        input_shifter[45]) );
  DFX2_HV \input_shifter_reg[6]  ( .D(inputs_a[6]), .CP(modesel_1), .Q(
        input_shifter[6]) );
  DFX2_HV \input_shifter_reg[14]  ( .D(input_shifter[6]), .CP(modesel_1), .Q(
        input_shifter[14]) );
  DFX2_HV \input_shifter_reg[22]  ( .D(input_shifter[14]), .CP(modesel_1), .Q(
        input_shifter[22]) );
  DFX2_HV \input_shifter_reg[30]  ( .D(input_shifter[22]), .CP(modesel_1), .Q(
        input_shifter[30]) );
  DFX2_HV \input_shifter_reg[38]  ( .D(input_shifter[30]), .CP(modesel_1), .Q(
        input_shifter[38]) );
  DFX2_HV \input_shifter_reg[46]  ( .D(input_shifter[38]), .CP(modesel_1), .Q(
        input_shifter[46]) );
  DFX2_HV \input_shifter_reg[7]  ( .D(inputs_a[7]), .CP(modesel_1), .Q(
        input_shifter[7]) );
  DFX2_HV \input_shifter_reg[15]  ( .D(input_shifter[7]), .CP(modesel_1), .Q(
        input_shifter[15]) );
  DFX2_HV \input_shifter_reg[23]  ( .D(input_shifter[15]), .CP(modesel_1), .Q(
        input_shifter[23]) );
  DFX2_HV \input_shifter_reg[31]  ( .D(input_shifter[23]), .CP(modesel_1), .Q(
        input_shifter[31]) );
  DFX2_HV \input_shifter_reg[39]  ( .D(input_shifter[31]), .CP(modesel_1), .Q(
        input_shifter[39]) );
  DFX2_HV \input_shifter_reg[47]  ( .D(input_shifter[39]), .CP(modesel_1), .Q(
        input_shifter[47]) );
  INVXL_HV U3 ( .A(acc_out[4]), .Q(n3) );
  INVXL_HV U4 ( .A(acc_out[1]), .Q(n2) );
  INVXL_HV U5 ( .A(acc_out[0]), .Q(n1) );
  LOGIC0_HV U6 ( .Q(\*Logic0* ) );
  LOGIC1_HV U7 ( .Q(\*Logic1* ) );
endmodule


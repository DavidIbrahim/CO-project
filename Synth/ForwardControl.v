/* Generated by Yosys 0.7 (git sha1 61f6811, i686-w64-mingw32.static-gcc 4.9.3 -Os) */

(* src = "D:\\NEW\\yosys-win32-mxebin-0.7\\ForwardControl.v:1" *)
module ForwardControl(EX_MEM_regWrite, MEM_WB_regWrite, EX_MEM_rd, MEM_WB_rd, MEM_WB_rt, regNoToCompareWz, forwardSignal);
  wire [1:0] _00_;
  wire _01_;
  wire [1:0] _02_;
  wire _03_;
  wire [1:0] _04_;
  wire _05_;
  wire [1:0] _06_;
  wire _07_;
  wire [1:0] _08_;
  wire _09_;
  wire [1:0] _10_;
  wire _11_;
  wire [4:0] _12_;
  wire [4:0] _13_;
  wire [4:0] _14_;
  wire _15_;
  wire _16_;
  wire _17_;
  (* src = "D:\\NEW\\yosys-win32-mxebin-0.7\\ForwardControl.v:15" *)
  wire _18_;
  (* src = "D:\\NEW\\yosys-win32-mxebin-0.7\\ForwardControl.v:20" *)
  wire _19_;
  (* src = "D:\\NEW\\yosys-win32-mxebin-0.7\\ForwardControl.v:9" *)
  wire _20_;
  (* src = "D:\\NEW\\yosys-win32-mxebin-0.7\\ForwardControl.v:15" *)
  wire _21_;
  (* src = "D:\\NEW\\yosys-win32-mxebin-0.7\\ForwardControl.v:15" *)
  wire _22_;
  (* src = "D:\\NEW\\yosys-win32-mxebin-0.7\\ForwardControl.v:20" *)
  wire _23_;
  (* src = "D:\\NEW\\yosys-win32-mxebin-0.7\\ForwardControl.v:20" *)
  wire _24_;
  (* src = "D:\\NEW\\yosys-win32-mxebin-0.7\\ForwardControl.v:9" *)
  wire _25_;
  (* src = "D:\\NEW\\yosys-win32-mxebin-0.7\\ForwardControl.v:9" *)
  wire _26_;
  (* src = "D:\\NEW\\yosys-win32-mxebin-0.7\\ForwardControl.v:15" *)
  wire _27_;
  (* src = "D:\\NEW\\yosys-win32-mxebin-0.7\\ForwardControl.v:20" *)
  wire _28_;
  (* src = "D:\\NEW\\yosys-win32-mxebin-0.7\\ForwardControl.v:9" *)
  wire _29_;
  wire [1:0] _30_;
  (* src = "D:\\NEW\\yosys-win32-mxebin-0.7\\ForwardControl.v:4" *)
  input [4:0] EX_MEM_rd;
  (* src = "D:\\NEW\\yosys-win32-mxebin-0.7\\ForwardControl.v:3" *)
  input EX_MEM_regWrite;
  (* src = "D:\\NEW\\yosys-win32-mxebin-0.7\\ForwardControl.v:4" *)
  input [4:0] MEM_WB_rd;
  (* src = "D:\\NEW\\yosys-win32-mxebin-0.7\\ForwardControl.v:3" *)
  input MEM_WB_regWrite;
  (* src = "D:\\NEW\\yosys-win32-mxebin-0.7\\ForwardControl.v:4" *)
  input [4:0] MEM_WB_rt;
  (* src = "D:\\NEW\\yosys-win32-mxebin-0.7\\ForwardControl.v:5" *)
  output [1:0] forwardSignal;
  (* src = "D:\\NEW\\yosys-win32-mxebin-0.7\\ForwardControl.v:4" *)
  input [4:0] regNoToCompareWz;
  assign _00_[0] = _14_[0] |(* src = "D:\\NEW\\yosys-win32-mxebin-0.7\\ForwardControl.v:15" *)  _14_[1];
  assign _00_[1] = _14_[2] |(* src = "D:\\NEW\\yosys-win32-mxebin-0.7\\ForwardControl.v:15" *)  _14_[3];
  assign _01_ = _00_[0] |(* src = "D:\\NEW\\yosys-win32-mxebin-0.7\\ForwardControl.v:15" *)  _00_[1];
  assign _15_ = _01_ |(* src = "D:\\NEW\\yosys-win32-mxebin-0.7\\ForwardControl.v:15" *)  _14_[4];
  assign _02_[0] = MEM_WB_rd[0] |(* src = "D:\\NEW\\yosys-win32-mxebin-0.7\\ForwardControl.v:15" *)  MEM_WB_rd[1];
  assign _02_[1] = MEM_WB_rd[2] |(* src = "D:\\NEW\\yosys-win32-mxebin-0.7\\ForwardControl.v:15" *)  MEM_WB_rd[3];
  assign _03_ = _02_[0] |(* src = "D:\\NEW\\yosys-win32-mxebin-0.7\\ForwardControl.v:15" *)  _02_[1];
  assign _27_ = _03_ |(* src = "D:\\NEW\\yosys-win32-mxebin-0.7\\ForwardControl.v:15" *)  MEM_WB_rd[4];
  assign _04_[0] = _12_[0] |(* src = "D:\\NEW\\yosys-win32-mxebin-0.7\\ForwardControl.v:20" *)  _12_[1];
  assign _04_[1] = _12_[2] |(* src = "D:\\NEW\\yosys-win32-mxebin-0.7\\ForwardControl.v:20" *)  _12_[3];
  assign _05_ = _04_[0] |(* src = "D:\\NEW\\yosys-win32-mxebin-0.7\\ForwardControl.v:20" *)  _04_[1];
  assign _16_ = _05_ |(* src = "D:\\NEW\\yosys-win32-mxebin-0.7\\ForwardControl.v:20" *)  _12_[4];
  assign _06_[0] = MEM_WB_rt[0] |(* src = "D:\\NEW\\yosys-win32-mxebin-0.7\\ForwardControl.v:20" *)  MEM_WB_rt[1];
  assign _06_[1] = MEM_WB_rt[2] |(* src = "D:\\NEW\\yosys-win32-mxebin-0.7\\ForwardControl.v:20" *)  MEM_WB_rt[3];
  assign _07_ = _06_[0] |(* src = "D:\\NEW\\yosys-win32-mxebin-0.7\\ForwardControl.v:20" *)  _06_[1];
  assign _28_ = _07_ |(* src = "D:\\NEW\\yosys-win32-mxebin-0.7\\ForwardControl.v:20" *)  MEM_WB_rt[4];
  assign _08_[0] = _13_[0] |(* src = "D:\\NEW\\yosys-win32-mxebin-0.7\\ForwardControl.v:9" *)  _13_[1];
  assign _08_[1] = _13_[2] |(* src = "D:\\NEW\\yosys-win32-mxebin-0.7\\ForwardControl.v:9" *)  _13_[3];
  assign _09_ = _08_[0] |(* src = "D:\\NEW\\yosys-win32-mxebin-0.7\\ForwardControl.v:9" *)  _08_[1];
  assign _17_ = _09_ |(* src = "D:\\NEW\\yosys-win32-mxebin-0.7\\ForwardControl.v:9" *)  _13_[4];
  assign _10_[0] = EX_MEM_rd[0] |(* src = "D:\\NEW\\yosys-win32-mxebin-0.7\\ForwardControl.v:9" *)  EX_MEM_rd[1];
  assign _10_[1] = EX_MEM_rd[2] |(* src = "D:\\NEW\\yosys-win32-mxebin-0.7\\ForwardControl.v:9" *)  EX_MEM_rd[3];
  assign _11_ = _10_[0] |(* src = "D:\\NEW\\yosys-win32-mxebin-0.7\\ForwardControl.v:9" *)  _10_[1];
  assign _29_ = _11_ |(* src = "D:\\NEW\\yosys-win32-mxebin-0.7\\ForwardControl.v:9" *)  EX_MEM_rd[4];
  assign _18_ = ~(* src = "D:\\NEW\\yosys-win32-mxebin-0.7\\ForwardControl.v:15" *) _15_;
  assign _19_ = ~(* src = "D:\\NEW\\yosys-win32-mxebin-0.7\\ForwardControl.v:20" *) _16_;
  assign _20_ = ~(* src = "D:\\NEW\\yosys-win32-mxebin-0.7\\ForwardControl.v:9" *) _17_;
  assign _21_ = _18_ &(* src = "D:\\NEW\\yosys-win32-mxebin-0.7\\ForwardControl.v:15" *)  MEM_WB_regWrite;
  assign _22_ = _21_ &(* src = "D:\\NEW\\yosys-win32-mxebin-0.7\\ForwardControl.v:15" *)  _27_;
  assign _23_ = _19_ &(* src = "D:\\NEW\\yosys-win32-mxebin-0.7\\ForwardControl.v:20" *)  MEM_WB_regWrite;
  assign _24_ = _23_ &(* src = "D:\\NEW\\yosys-win32-mxebin-0.7\\ForwardControl.v:20" *)  _28_;
  assign _25_ = _20_ &(* src = "D:\\NEW\\yosys-win32-mxebin-0.7\\ForwardControl.v:9" *)  EX_MEM_regWrite;
  assign _26_ = _25_ &(* src = "D:\\NEW\\yosys-win32-mxebin-0.7\\ForwardControl.v:9" *)  _29_;
  assign _30_[0] = _22_ ? (* src = "D:\\NEW\\yosys-win32-mxebin-0.7\\ForwardControl.v:15" *) 1'b0 : _24_;
  assign _30_[1] = _22_ ? (* src = "D:\\NEW\\yosys-win32-mxebin-0.7\\ForwardControl.v:15" *) 1'b1 : _24_;
  assign forwardSignal[0] = _26_ ? (* src = "D:\\NEW\\yosys-win32-mxebin-0.7\\ForwardControl.v:9" *) 1'b1 : _30_[0];
  assign forwardSignal[1] = _26_ ? (* src = "D:\\NEW\\yosys-win32-mxebin-0.7\\ForwardControl.v:9" *) 1'b0 : _30_[1];
  assign _14_[4] = MEM_WB_rd[4] ^(* src = "D:\\NEW\\yosys-win32-mxebin-0.7\\ForwardControl.v:15" *)  regNoToCompareWz[4];
  assign _12_[0] = MEM_WB_rt[0] ^(* src = "D:\\NEW\\yosys-win32-mxebin-0.7\\ForwardControl.v:20" *)  regNoToCompareWz[0];
  assign _12_[1] = MEM_WB_rt[1] ^(* src = "D:\\NEW\\yosys-win32-mxebin-0.7\\ForwardControl.v:20" *)  regNoToCompareWz[1];
  assign _12_[2] = MEM_WB_rt[2] ^(* src = "D:\\NEW\\yosys-win32-mxebin-0.7\\ForwardControl.v:20" *)  regNoToCompareWz[2];
  assign _12_[3] = MEM_WB_rt[3] ^(* src = "D:\\NEW\\yosys-win32-mxebin-0.7\\ForwardControl.v:20" *)  regNoToCompareWz[3];
  assign _12_[4] = MEM_WB_rt[4] ^(* src = "D:\\NEW\\yosys-win32-mxebin-0.7\\ForwardControl.v:20" *)  regNoToCompareWz[4];
  assign _13_[0] = EX_MEM_rd[0] ^(* src = "D:\\NEW\\yosys-win32-mxebin-0.7\\ForwardControl.v:9" *)  regNoToCompareWz[0];
  assign _13_[1] = EX_MEM_rd[1] ^(* src = "D:\\NEW\\yosys-win32-mxebin-0.7\\ForwardControl.v:9" *)  regNoToCompareWz[1];
  assign _13_[2] = EX_MEM_rd[2] ^(* src = "D:\\NEW\\yosys-win32-mxebin-0.7\\ForwardControl.v:9" *)  regNoToCompareWz[2];
  assign _13_[3] = EX_MEM_rd[3] ^(* src = "D:\\NEW\\yosys-win32-mxebin-0.7\\ForwardControl.v:9" *)  regNoToCompareWz[3];
  assign _13_[4] = EX_MEM_rd[4] ^(* src = "D:\\NEW\\yosys-win32-mxebin-0.7\\ForwardControl.v:9" *)  regNoToCompareWz[4];
  assign _14_[0] = MEM_WB_rd[0] ^(* src = "D:\\NEW\\yosys-win32-mxebin-0.7\\ForwardControl.v:15" *)  regNoToCompareWz[0];
  assign _14_[1] = MEM_WB_rd[1] ^(* src = "D:\\NEW\\yosys-win32-mxebin-0.7\\ForwardControl.v:15" *)  regNoToCompareWz[1];
  assign _14_[2] = MEM_WB_rd[2] ^(* src = "D:\\NEW\\yosys-win32-mxebin-0.7\\ForwardControl.v:15" *)  regNoToCompareWz[2];
  assign _14_[3] = MEM_WB_rd[3] ^(* src = "D:\\NEW\\yosys-win32-mxebin-0.7\\ForwardControl.v:15" *)  regNoToCompareWz[3];
endmodule

// Leo's first chip: 8-LED chaser for Tiny Tapeout
`default_nettype none

module tt_um_leo_led_chaser (
    input  wire [7:0] ui_in,
    output wire [7:0] uo_out,
    input  wire [7:0] uio_in,
    output wire [7:0] uio_out,
    output wire [7:0] uio_oe,
    input  wire       ena,
    input  wire       clk,
    input  wire       rst_n
);

  wire       dir   = ui_in[0];
  wire [1:0] speed = ui_in[2:1];

  reg [21:0] div;
  always @(posedge clk) begin
    if (!rst_n)
      div <= 22'd0;
    else
      div <= div + 22'd1;
  end

  wire tick = div[18 + speed];

  reg tick_d;
  always @(posedge clk) begin
    if (!rst_n)
      tick_d <= 1'b0;
    else
      tick_d <= tick;
  end
  wire step_pulse = tick & ~tick_d;

  reg [7:0] pattern;
  always @(posedge clk) begin
    if (!rst_n)
      pattern <= 8'b0000_0001;
    else if (step_pulse) begin
      if (dir)
        pattern <= {pattern[0], pattern[7:1]};
      else
        pattern <= {pattern[6:0], pattern[7]};
    end
  end

  assign uo_out  = pattern;
  assign uio_out = 8'b0;
  assign uio_oe  = 8'b0;

  wire _unused = &{ena, uio_in, ui_in[7:3], 1'b0};

endmodule

`default_nettype none // Overrides default behaviour (in a good way)

module led_array_driver(ena, x, cells, rows, cols);
  // Module I/O and parameters
  parameter N=8; // Size of Conway Cell Grid.
  parameter ROWS=N;
  parameter COLS=N;

  // I/O declarations
  input wire ena;
  input wire [$clog2(N):0] x;
  input wire [N*N-1:0] cells;
  output logic [N-1:0] rows;
  output logic [N-1:0] cols;

  // You can check parameters with the $error macro within initial blocks.
  initial begin
    if ((N <= 0) || (N > 8)) begin
      $error("N must be within 0 and 8.");
    end
    if (ROWS != COLS) begin
      $error("Non square led arrays are not supported. (%dx%d)", ROWS, COLS);
    end
    if (ROWS < N) begin
      $error("ROWS/COLS must be >= than the size of the Conway Grid.");
    end
  end

  wire [N-1:0] x_decoded;
  decoder_3_to_8 COL_DECODER(ena, x, x_decoded);

  always_comb begin : blockName
    cols = x_decoded[N-1:0];

    rows[0] = ~| (cells[0*N+N-1: 0*(N)] & cols[N-1:0]);
    rows[1] = ~| (cells[1*N+N-1: 1*(N)] & cols[N-1:0]);
    rows[2] = ~| (cells[2*N+N-1: 2*(N)] & cols[N-1:0]);
    rows[3] = ~| (cells[3*N+N-1: 3*(N)] & cols[N-1:0]);
    rows[4] = ~| (cells[4*N+N-1: 4*(N)] & cols[N-1:0]);
    rows[5] = ~| (cells[5*N+N-1: 5*(N)] & cols[N-1:0]);
    rows[6] = ~| (cells[6*N+N-1: 6*(N)] & cols[N-1:0]);
    rows[7] = ~| (cells[7*N+N-1: 7*(N)] & cols[N-1:0]);
  end
  
endmodule

`default_nettype wire // reengages default behaviour, needed when using 
                      // other designs that expect it.
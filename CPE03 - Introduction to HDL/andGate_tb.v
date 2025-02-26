module keqing;

    initial begin

        $dumpfile("Liyue.vcd");
        $dumpvars(0, Liyue);

    end

    reg zhongli = 0;
    reg ganyu = 0;

    always #5 zhongli = !zhongli; 
    always #5 ganyu = !zhongli;

endmodule
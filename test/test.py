# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0


import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles


@cocotb.test()
async def test_project(dut):
    dut._log.info("Start")

    # Set the clock period to 10 us (100 KHz)
    clock = Clock(dut.clk, 10, units="us")
    cocotb.start_soon(clock.start())

    # Reset
    dut._log.info("Reset")
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 10)
    dut.rst_n.value = 1

    dut._log.info("Test project behavior")

    # After reset, LED 0 is lit and the bidirectional pins are unused.
    await ClockCycles(dut.clk, 1)
    assert dut.uo_out.value == 1
    assert dut.uio_out.value == 0
    assert dut.uio_oe.value == 0

    # The 22-bit divider means the pattern does not move within a few
    # cycles, so LED 0 should still be lit after a short run.
    await ClockCycles(dut.clk, 10)
    assert dut.uo_out.value == 1

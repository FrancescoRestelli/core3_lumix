#pragma once

#include <inttypes.h>
#include "Stream.h"
//SERIALDEBUG_VERBOSE
#define SERIALDEBUG
#define ONEWIRE //disables the RX pin while sending
//#define DEBUG_VERBOSE

//#include "IntervalTimer.h"

#define _SSS_TX_BUFFER_SIZE 64
#define _SSS_RX_BUFFER_SIZE 64

#define _SSS_MAX_OPTABLE_SIZE 48 // 4 ops per bit, 8E2 is 12 bits long

#define _SSS_MIN_BAUDRATE 1.0 // arbitrary; don't divide by zero.

// Definitions for an extension to the ::end() method
#define SSS_RETAIN_PINS (true)
#define SSS_RELEASE_PINS (false)

// Definitions for databits, parity, and stopbits configuration word.
// These are taken from the official Arduino API, but I've had to rename
// them because other serial libraries are not consistent with these
// official values.
#define SSS_SERIAL_PARITY_EVEN (0x1ul)
#define SSS_SERIAL_PARITY_ODD (0x2ul)
#define SSS_SERIAL_PARITY_NONE (0x3ul)
#define SSS_SERIAL_PARITY_MARK (0x4ul)
#define SSS_SERIAL_PARITY_SPACE (0x5ul)
#define SSS_SERIAL_PARITY_MASK (0xFul)

#define SSS_SERIAL_STOP_BIT_1 (0x10ul)
#define SSS_SERIAL_STOP_BIT_1_5 (0x20ul)
#define SSS_SERIAL_STOP_BIT_2 (0x30ul)
#define SSS_SERIAL_STOP_BIT_MASK (0xF0ul)

#define SSS_SERIAL_DATA_5 (0x100ul)
#define SSS_SERIAL_DATA_6 (0x200ul)
#define SSS_SERIAL_DATA_7 (0x300ul)
#define SSS_SERIAL_DATA_8 (0x400ul)
#define SSS_SERIAL_DATA_MASK (0xF00ul)

#define SSS_SERIAL_5N1 (SSS_SERIAL_STOP_BIT_1 | SSS_SERIAL_PARITY_NONE | SSS_SERIAL_DATA_5)
#define SSS_SERIAL_6N1 (SSS_SERIAL_STOP_BIT_1 | SSS_SERIAL_PARITY_NONE | SSS_SERIAL_DATA_6)
#define SSS_SERIAL_7N1 (SSS_SERIAL_STOP_BIT_1 | SSS_SERIAL_PARITY_NONE | SSS_SERIAL_DATA_7)
#define SSS_SERIAL_8N1 (SSS_SERIAL_STOP_BIT_1 | SSS_SERIAL_PARITY_NONE | SSS_SERIAL_DATA_8)
#define SSS_SERIAL_8N15 (SSS_SERIAL_STOP_BIT_1_5 | SSS_SERIAL_PARITY_NONE | SSS_SERIAL_DATA_8)
#define SSS_SERIAL_5N2 (SSS_SERIAL_STOP_BIT_2 | SSS_SERIAL_PARITY_NONE | SSS_SERIAL_DATA_5)
#define SSS_SERIAL_6N2 (SSS_SERIAL_STOP_BIT_2 | SSS_SERIAL_PARITY_NONE | SSS_SERIAL_DATA_6)
#define SSS_SERIAL_7N2 (SSS_SERIAL_STOP_BIT_2 | SSS_SERIAL_PARITY_NONE | SSS_SERIAL_DATA_7)
#define SSS_SERIAL_8N2 (SSS_SERIAL_STOP_BIT_2 | SSS_SERIAL_PARITY_NONE | SSS_SERIAL_DATA_8)
#define SSS_SERIAL_5E1 (SSS_SERIAL_STOP_BIT_1 | SSS_SERIAL_PARITY_EVEN | SSS_SERIAL_DATA_5)
#define SSS_SERIAL_6E1 (SSS_SERIAL_STOP_BIT_1 | SSS_SERIAL_PARITY_EVEN | SSS_SERIAL_DATA_6)
#define SSS_SERIAL_7E1 (SSS_SERIAL_STOP_BIT_1 | SSS_SERIAL_PARITY_EVEN | SSS_SERIAL_DATA_7)
#define SSS_SERIAL_8E1 (SSS_SERIAL_STOP_BIT_1 | SSS_SERIAL_PARITY_EVEN | SSS_SERIAL_DATA_8)
#define SSS_SERIAL_5E2 (SSS_SERIAL_STOP_BIT_2 | SSS_SERIAL_PARITY_EVEN | SSS_SERIAL_DATA_5)
#define SSS_SERIAL_6E2 (SSS_SERIAL_STOP_BIT_2 | SSS_SERIAL_PARITY_EVEN | SSS_SERIAL_DATA_6)
#define SSS_SERIAL_7E2 (SSS_SERIAL_STOP_BIT_2 | SSS_SERIAL_PARITY_EVEN | SSS_SERIAL_DATA_7)
#define SSS_SERIAL_8E2 (SSS_SERIAL_STOP_BIT_2 | SSS_SERIAL_PARITY_EVEN | SSS_SERIAL_DATA_8)
#define SSS_SERIAL_5O1 (SSS_SERIAL_STOP_BIT_1 | SSS_SERIAL_PARITY_ODD | SSS_SERIAL_DATA_5)
#define SSS_SERIAL_6O1 (SSS_SERIAL_STOP_BIT_1 | SSS_SERIAL_PARITY_ODD | SSS_SERIAL_DATA_6)
#define SSS_SERIAL_7O1 (SSS_SERIAL_STOP_BIT_1 | SSS_SERIAL_PARITY_ODD | SSS_SERIAL_DATA_7)
#define SSS_SERIAL_8O1 (SSS_SERIAL_STOP_BIT_1 | SSS_SERIAL_PARITY_ODD | SSS_SERIAL_DATA_8)
#define SSS_SERIAL_5O2 (SSS_SERIAL_STOP_BIT_2 | SSS_SERIAL_PARITY_ODD | SSS_SERIAL_DATA_5)
#define SSS_SERIAL_6O2 (SSS_SERIAL_STOP_BIT_2 | SSS_SERIAL_PARITY_ODD | SSS_SERIAL_DATA_6)
#define SSS_SERIAL_7O2 (SSS_SERIAL_STOP_BIT_2 | SSS_SERIAL_PARITY_ODD | SSS_SERIAL_DATA_7)
#define SSS_SERIAL_8O2 (SSS_SERIAL_STOP_BIT_2 | SSS_SERIAL_PARITY_ODD | SSS_SERIAL_DATA_8)
#define SSS_SERIAL_5M1 (SSS_SERIAL_STOP_BIT_1 | SSS_SERIAL_PARITY_MARK | SSS_SERIAL_DATA_5)
#define SSS_SERIAL_6M1 (SSS_SERIAL_STOP_BIT_1 | SSS_SERIAL_PARITY_MARK | SSS_SERIAL_DATA_6)
#define SSS_SERIAL_7M1 (SSS_SERIAL_STOP_BIT_1 | SSS_SERIAL_PARITY_MARK | SSS_SERIAL_DATA_7)
#define SSS_SERIAL_8M1 (SSS_SERIAL_STOP_BIT_1 | SSS_SERIAL_PARITY_MARK | SSS_SERIAL_DATA_8)
#define SSS_SERIAL_5M2 (SSS_SERIAL_STOP_BIT_2 | SSS_SERIAL_PARITY_MARK | SSS_SERIAL_DATA_5)
#define SSS_SERIAL_6M2 (SSS_SERIAL_STOP_BIT_2 | SSS_SERIAL_PARITY_MARK | SSS_SERIAL_DATA_6)
#define SSS_SERIAL_7M2 (SSS_SERIAL_STOP_BIT_2 | SSS_SERIAL_PARITY_MARK | SSS_SERIAL_DATA_7)
#define SSS_SERIAL_8M2 (SSS_SERIAL_STOP_BIT_2 | SSS_SERIAL_PARITY_MARK | SSS_SERIAL_DATA_8)
#define SSS_SERIAL_5S1 (SSS_SERIAL_STOP_BIT_1 | SSS_SERIAL_PARITY_SPACE | SSS_SERIAL_DATA_5)
#define SSS_SERIAL_6S1 (SSS_SERIAL_STOP_BIT_1 | SSS_SERIAL_PARITY_SPACE | SSS_SERIAL_DATA_6)
#define SSS_SERIAL_7S1 (SSS_SERIAL_STOP_BIT_1 | SSS_SERIAL_PARITY_SPACE | SSS_SERIAL_DATA_7)
#define SSS_SERIAL_8S1 (SSS_SERIAL_STOP_BIT_1 | SSS_SERIAL_PARITY_SPACE | SSS_SERIAL_DATA_8)
#define SSS_SERIAL_5S2 (SSS_SERIAL_STOP_BIT_2 | SSS_SERIAL_PARITY_SPACE | SSS_SERIAL_DATA_5)
#define SSS_SERIAL_6S2 (SSS_SERIAL_STOP_BIT_2 | SSS_SERIAL_PARITY_SPACE | SSS_SERIAL_DATA_6)
#define SSS_SERIAL_7S2 (SSS_SERIAL_STOP_BIT_2 | SSS_SERIAL_PARITY_SPACE | SSS_SERIAL_DATA_7)
#define SSS_SERIAL_8S2 (SSS_SERIAL_STOP_BIT_2 | SSS_SERIAL_PARITY_SPACE | SSS_SERIAL_DATA_8)
class SlowSoftSerial : public Stream
{
public:
    SlowSoftSerial(uint8_t rxPin, uint8_t txPin, bool inverse = true);
    ~SlowSoftSerial() { end(); }

    // Note we use a floating point value for baud rate. We can do that!
    // And if legacy code passes an integral value, it just gets converted.
    //duplex mode false turns off the RX interrupts while sending

    void begin(double baudrate, uint16_t config)
    {
        begin(baudrate, SSS_SERIAL_8N1);
    };
    void begin(double baudrate)
    {
        begin(baudrate, SSS_SERIAL_8N1);
    }

    void end(bool releasePins);
    void end() { end(SSS_RELEASE_PINS); }
    int available(void);
    int availableForWrite(void);
    int peek(void);
    bool stillSending(void);
    int read(void);
    void flush(void);
    size_t write(uint8_t);
    using Print::write; // pull in write(str) and write(buf, size) from Print
    int getTXBufferSize(void);
    operator bool() { return true; }; // we are always ready

    // listen is a SoftwareSerial thing, since it can only receive on one port.
    // We don't have that limitation, though we are limited by the number of timers.
    bool listen() { return false; }
    bool isListening() { return true; }

    // The standard Arduino serial API doesn't support handshaking, but the
    // Teensyduino UART API does support hardware handshaking. We adopt their
    // API.
    // void attachRts(uint8_t); not yet implemented
    void attachCts(uint8_t);

    // Unfortunately, this has to be public because of the horrific workaround
    // needed to register a callback with IntervalTimer or attachInterrupt.
    void _tx_handler(void);
    void _rx_timer_handler(void);
    void _rx_start_handler(void);

private:
    inline void digitalWrite_fast(int pin, bool val)
    {
        if (val)
            PORT->Group[g_APinDescription[pin].ulPort].OUTSET.reg = (1ul << g_APinDescription[pin].ulPin);
        else
            PORT->Group[g_APinDescription[pin].ulPort].OUTCLR.reg = (1ul << g_APinDescription[pin].ulPin);
    }

    inline int digitalRead_fast(int pin)
    {
        return !!(PORT->Group[g_APinDescription[pin].ulPort].IN.reg & (1ul << g_APinDescription[pin].ulPin));
    }
    static int _active_count;
    bool _instance_active;

    uint16_t _add_parity(uint8_t chr);
    void _fill_op_table(int rxbits, int stopbits);

    // port configuration
    double _baud_microseconds; // one baud in microseconds
    double _rx_microseconds;   // receive sample rate
    uint16_t _parity;          // use definitions above, like ones in HardwareSerial.h
    uint8_t _num_bits_to_send; // includes parity and stop bit(s) but not start bit
    uint16_t _parity_bit;      // bitmask for the parity bit; 0 if no parity
    int16_t _stop_bits;        // bit(s) to OR in to data word
    uint8_t _databits_mask;    // bitmask of bits that fit in the word size
    uint16_t _rx_shiftin_bit;  // bit to OR in to data word as received bits shift in
    uint8_t _rxPin;
    uint8_t _txPin;
    uint8_t _rtsPin;
    uint8_t _ctsPin;
    bool _rts_attached;
    bool _cts_attached;
    bool _inverse;
    //IntervalTimer _tx_timer;
    //IntervalTimer _rx_timer;

    // transmit buffer and its variables
    volatile int _tx_buffer_count;
    int _tx_write_index;
    int _tx_read_index;
    uint16_t _tx_buffer[_SSS_TX_BUFFER_SIZE]; // contains data "as sent" with parity and stop bits

    // transmit state
    int _tx_data_word;
    int _tx_bit_count;

    bool _tx_enabled = true;
    bool _tx_running = false;

    // receive buffer and its variables
    volatile int _rx_buffer_count;
    int _rx_write_index;
    int _rx_read_index;
    uint16_t _rx_buffer[_SSS_RX_BUFFER_SIZE]; // contains data with parity (no stop bits)

    // receive state
    uint8_t _rx_op_table[_SSS_MAX_OPTABLE_SIZE];
    uint8_t _rx_op;         // index into the operation table
    uint16_t _rx_data_word; // word under construction as we receive it
    int _rx_bit_value;      // bit value as we sample it repeatedly
};

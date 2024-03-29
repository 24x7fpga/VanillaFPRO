#ifndef _GPIO_H_INCLUDED
#define _GPIO_H_INCLUDED

#include "chu_init.h"

// GPO CORE CLASS DEFINITION
class GpoCore {
 public:
   /*register map*/
   enum {
       DATA_REG = 0                         // data register
   };
   
   GpoCore(uint32_t  core_base_addr);       // constructor
   ~GpoCore();                              // destructor; not used

   void write(uint32_t data);               // write a 32-bit word
   void write(int bit_value, int bit_pos);  // write 1 bit (overload)

 private:
   uint32_t base_addr;
   uint32_t wr_data;                       // same as GPO core date reg 

};

// GPI CORE CLASS DEFINITION
class GpiCore {
 public:
  /*register map*/
  enum{
    DATA_REG = 0                          // data register
  };

  GpiCore(uint32_t core_base_addr);       // constructor
  ~GpiCore();                             // destructor; not used

  uint32_t read();                        // read a 32-bit word
  int read(int bit_pos);                  // read 1-bit 
 
 private:
  uint32_t base_addr;
};

#endif

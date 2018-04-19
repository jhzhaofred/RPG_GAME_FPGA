
 
 
 




window new WaveWindow  -name  "Waves for BMG Example Design"
waveform  using  "Waves for BMG Example Design"


      waveform add -signals /Enemy_tb/status
      waveform add -signals /Enemy_tb/Enemy_synth_inst/bmg_port/CLKA
      waveform add -signals /Enemy_tb/Enemy_synth_inst/bmg_port/ADDRA
      waveform add -signals /Enemy_tb/Enemy_synth_inst/bmg_port/DOUTA
console submit -using simulator -wait no "run"

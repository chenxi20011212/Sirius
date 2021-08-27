.PHONY: all
all: spectrum.png light_curve.png energy_response.gif

spectrum.png: source.h5
	python3 energy_spectrum.py $^ $@

light_curve.png: light_curve.h5

light_curve.h5: source.h5 data/constant.json
	python3 source_generate.py $^ $@

energy_response.h5: data/matrix/Cube*_det*.rsp light_curve.h5 data/constant.json
	python3 calculate_response.py $^ $@

energy_response.gif: energy_response.h5
	python3 plot_signal.py $^ $@

.PHONY: clean
clean:
	rm -rf *.h5 *.png *.gif

# Delete partial files when the processes are killed.
.DELETE_ON_ERROR:
# Keep intermediate files around
.SECONDARY:

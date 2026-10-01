# Rebuilds the figures and the paper. Requires pdflatex and pdftocairo (poppler).
FIGS := fig1-boundary fig2-lifecycle fig3-claims

all: proposal-boundary.pdf

figures/%.pdf: figures/%.tex figures/style.tex
	cd figures && pdflatex -interaction=nonstopmode -halt-on-error $*.tex >/dev/null
	cd figures && pdftocairo -png -singlefile -r 220 $*.pdf $*
	cd figures && rm -f $*.aux $*.log

proposal-boundary.pdf: proposal-boundary.tex $(FIGS:%=figures/%.pdf)
	pdflatex -interaction=nonstopmode -halt-on-error proposal-boundary.tex >/dev/null
	pdflatex -interaction=nonstopmode -halt-on-error proposal-boundary.tex >/dev/null
	rm -f proposal-boundary.aux proposal-boundary.log proposal-boundary.out

clean:
	rm -f *.aux *.log *.out figures/*.aux figures/*.log

.PHONY: all clean

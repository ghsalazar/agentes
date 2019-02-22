CODE     = Agents.js robots.js ejemplo.1.js ejemplo.2.js \
           ejemplo.1.html ejemplo.2.html

TARGETS  = $(patsubst %.noweb,%.html,$(wildcard *.noweb)) $(patsubst %.noweb,%.pdf,$(wildcard *.noweb)) $(patsubst %.noweb,%.markdown,$(wildcard *.noweb))

HTMLFLAGS = --from markdown --to html5 --smart --standalone \
            --css http://necolas.github.io/normalize.css/latest/normalize.css \
            --css http://ghsalazar.github.io/site/site.css

DOCXFLAGS = --reference-doc=Plantilla.docx

all: $(TARGETS) $(CODE)

$(CODE): $(wildcard *.noweb)
	notangle -R$@ $< > $@

$(EXAMPLES): $(wildcard *.noweb)
	notangle -R$@ $< > $@

%.markdown: %.noweb
	sed -e 's/<<.*\.html>>=/````html/' -e 's/@/````/' -e 's/<<.*\.js>>=/````javascript/' $< > $@

%.html: %.markdown
	php $< | pandoc $(HTMLFLAGS) -o $@

%.pdf: %.markdown
	pandoc --listings -o $@ $<

.PHONNY: clean

clean:
	rm -rf $(TARGETS) $(CODE) *~

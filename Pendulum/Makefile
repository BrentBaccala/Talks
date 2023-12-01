
# Makefile to call the GPT-4 API to convert a GPT prompt into a sage script to plot a double pendulum.

# We need to use /bin/bash to use pipefail, which is a bash option that causes a pipeline
# to fail if any command in the pipeline fails.  The command in question is "jq", which
# takes the --exit-status option to fail if its output value is null.  That's what I
# want to do if there's some kind of problem (like authentication) with the API call.

SHELL := /bin/bash

URL := https://api.openai.com/v1/chat/completions

pendulum.sage: pendulum.gpt
ifndef OPENAI_API_KEY
	$(error OPENAI_API_KEY is undefined)
endif
	set -o pipefail && jq -n --arg content "$$(cat pendulum.gpt)" \
	  '{ "model": "gpt-4", "messages": [{"role": "user", "content": $$content}], "temperature": 0  }' \
	  | curl --silent $(URL) -H "Content-Type: application/json" -H "Authorization: Bearer $$OPENAI_API_KEY" -d @- \
	  | jq --exit-status -r .choices[0].message.content \
	  | grep -v -e '^```$$' -e '^```python$$' > pendulum.sage
	chmod a+x pendulum.sage
	@cat pendulum.sage

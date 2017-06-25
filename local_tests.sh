#!/bin/bash

echo "Running Foodcritic"
foodcritic .

echo "Running RuboCop"
rubocop -r cookstyle

echo "Runing Chefspec"
chef exec rspec

echo "Runing Kitchen Verify"
kitchen verify

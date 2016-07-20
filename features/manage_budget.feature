#-- copyright
# OpenProject Costs Plugin
#
# Copyright (C) 2009 - 2014 the OpenProject Foundation (OPF)
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# version 3.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#++

Feature: Managing Budgets

  Background:
    Given there is 1 User with:
      | Login        | testuser |
      | firstname    | Chuck    |
      | lastname     | Testa    |
      | default rate | 37       |
    And there is 1 Project with the following:
      | name       | project1 |
      | identifier | project1 |
    And there is a role "manager"
    And the role "manager" may have the following rights:
      | edit_cost_objects |
      | view_cost_rates   |
      | view_hourly_rates |
    And there is 1 cost type with the following:
      | name         | cost_type_1 |
      | unit         | single_unit |
      | unit_plural  | multi_unit  |
      | cost_rate    | 40          |
    And the user "testuser" is a "manager" in the project "project1"
    And I am already logged in as "testuser"

@javascript
  Scenario: Budgets can be copied
  Given there is a budget with the following:
      | subject | budget1  |
      | author  | testuser |
      | project | project1 |
    And the budget "budget1" has the following material items:
      | units | comment              | cost_type     |
      |   10  | materialtestcomment  | cost_type_1   |
      |    6  | materialtestcomment2 | cost_type_1   |
    And the budget "budget1" has the following labor items:
      | hours | comment           | user     |
      |    8  | labortestcomment  | testuser |
      |    5  | labortestcomment2 | testuser |
    And I go to the show page of the budget "budget1"
    When I click on "Copy"
    Then I should see "New budget"
    And the planned material costs in row 1 should be "400.00 EUR"
    And the planned labor costs in row 1 should be "296.00 EUR"
    And the planned material costs in row 2 should be "240.00 EUR"
    And the planned labor costs in row 2 should be "185.00 EUR"

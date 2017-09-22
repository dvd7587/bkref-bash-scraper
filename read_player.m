## Copyright (C) 2017 Davide Cagnoni
## 
## This program is free software; you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 3 of the License, or
## (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <http://www.gnu.org/licenses/>.

## -*- texinfo -*- 
## @deftypefn {Function File} {@var{retval} =} read_player (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Davide Cagnoni <dcagnoni@henesis83>
## Created: 2017-09-22

function [player] = read_player (filename)

FORMAT = [...
    ";%u;%u;%u-%u-%u;"...
    "%u-%u;%3s;%1s;%3s;"...
    "%1s;%d;%u;%u:%u;"...
    "%u;%u;%f;%u;%u;"...
    "%f;%u;%u;%f;%u;"...
    "%u;%u;%u;%u;%u;"...
    "%u;%u;%u;%f;%d;" ];

[...
p.Rk     p.G       p.DateY   p.DateM   p.DateD	...
p.AgeY   p.AgeD    p.Tm      p.Loc     p.Opp ...
p.WL     p.PTdif   p.GS      p.MPm     p.MPs ...
p.FG     p.FGA     p.FGpc    p.FG3     p.FG3A ...
p.FG3pc  p.FT      p.FTA     p.FTpc    p.ORB ...
p.DRB    p.TRB     p.AST     p.STL     p.BLK ...
p.TOV    p.PF      p.PTS     p.GmSc    p.PluMin] = textread (filename, FORMAT);

p.Tm = cell2mat(p.Tm);
p.Loc = cell2mat(p.Loc);
p.Opp = cell2mat(p.Opp);
p.WL = cell2mat(p.WL);

player = p;

endfunction

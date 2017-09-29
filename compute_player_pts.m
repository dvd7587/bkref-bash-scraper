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
## @deftypefn {Function File} {@var{player_struct} =} compute_player_pts (@var{player_struct})
##
## Needs fields:
## Date   : DateY , DateM, DateD
## Age    : AgeY, AgeD
## BWSsc  : FT, FTA, FG, FGA, FG3, FG3A,
##          AST, ORB, DRB, BLK, STL, TOV, WL
## BWSscm : MPm, MPs
##
## @seealso{read_player}
## @end deftypefn

## Author: Davide Cagnoni <dcagnoni@henesis83>
## Created: 2017-09-22

function [player] = compute_player_pts (p)

monthdays = cumsum([0 31 28 31 30 31 30 31 31 30 31 30 31])';

# p.Rk     p.G       p.DateY   p.DateM   p.DateD	...
# p.AgeY   p.AgeD    p.Tm      p.Loc     p.Opp ...
# p.WL     p.PTdif   p.GS      p.MPm     p.MPs ...
# p.FG     p.FGA     p.FGpc    p.FG3     p.FG3A ...
# p.FG3pc  p.FT      p.FTA     p.FTpc    p.ORB ...
# p.DRB    p.TRB     p.AST     p.STL     p.BLK ...
# p.TOV    p.PF      p.PTS     p.GmSc    p.PluMin

p.Date = (double(p.DateY)-2000)*365+ monthdays(double(p.DateM)) + double(p.DateD);
p.Age  = p.AgeY*365+ p.AgeD;

p.BWSsc = double(p.FT)   * 2.0 + ...
          double(p.FTA)  * -1.0 + ...
          double(p.FG)   * 2.8 + ...
          double(p.FGA)  * -0.8 + ...
          double(p.FG3)  * 0.9 + ...
          double(p.FG3A) * 0.1 + ...
          double(p.AST)  * 1.0 + ...
          double(p.ORB)  * 1.2 + ...
          double(p.DRB)  * 1.0 + ...
          double(p.BLK)  * 1.0 + ...
          double(p.STL)  * 1.0 + ...
          double(p.TOV)  * -1.0 + ...
          double(p.WL == 'W') * 1.0 + double(p.WL == 'L') * -1.0 ...
          ;

p.BWSscm = p.BWSsc ./ double(p.MPm + (p.MPs>=30));

#               j   f   m   a   m   j   j   a   s   o   n   d 
seasonmonths = [3-7 4-7 5-7 6-7 7-7 7-7 0-1 0-1 0-1 0+1 0+1 0+2]';
p.MonthID = (p.DateY - 2000)*7 + seasonmonths(p.DateM);

u = double(unique(p.MonthID));
p.tr_MI = u;
p.tr_MP = u;
p.tr_sc = u; 
p.tr_pm = u;

for i = 1:numel(u)
m = u(i); 
mask = p.MonthID==m;

p.tr_MI(i)=m;
p.tr_MP(i)=mean(double(p.MPm(mask))*60 + double(p.MPs(mask)))/60;
p.tr_sc(i)=mean(double(p.BWSsc(mask)));
p.tr_pm(i)=sum(p.BWSsc(mask))./(sum(mask) * p.tr_MP(i));

endfor 

player = p;
endfunction

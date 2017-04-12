# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.

immutable BasisBlade

	# Bitmap encodes basis indices
	#
	# 0000000000000000 = 1.0		# Scalar
	# 0000000000000001 = e₁
	# 0000000000000010 = e₂
	# 0000000000000011 = e₁e₂ ...

    bitmap::UInt16

	BasisBlade(val) = new(convert(UInt16, val))
end

# A few literals for convenience

const e₁ = BasisBlade(1)
const e₂ = BasisBlade(2)
const e₁e₂ = BasisBlade(3)
const e₃ = BasisBlade(4)

grade(a::BasisBlade) = bitcount(a.bitmap)

function bitcount(n::UInt16)
	return sum((n & (1 << k)) >> k for k in 0:16)
end

function string(a::BasisBlade)
	k = 0
	n = a.bitmap
	buf = IOBuffer()
	ee = ["₁", "₂", "₃", "₄", "₅", "₆", "₇", "₈", 
		  "₉", "₁₀", "₁₁", "₁₂", "₁₃", "₁₄", "₁₅", "₁₆"]
	
	while k < 16
		if (n & (1 << k)) >> k == 1
			print(buf, "e"*ee[k+1])
		end
		k += 1
	end
	
	return takebuf_string(buf)
end

function show(io::IO, a::BasisBlade)
    print(io, string(a))
end


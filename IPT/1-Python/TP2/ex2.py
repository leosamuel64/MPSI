def estRectangleEnB(A,B,C):
	xA,yA = A
	xB,yB = B
	xC,yC = C

	AB = ((xB-xA)**2 +(yB-yA)**2)**0.5
	AC = ((xC-xA)**2 +(yC-yA)**2)**0.5
	BC = ((xC-xB)**2 +(yC-yB)**2)**0.5

	return (AB**2 + BC**2)**0.5 == AC

def estRectangle(A,B,C):
	xA,yA = A
	xB,yB = B
	xC,yC = C

	AB = ((xB-xA)**2 +(yB-yA)**2)**0.5
	AC = ((xC-xA)**2 +(yC-yA)**2)**0.5
	BC = ((xC-xB)**2 +(yC-yB)**2)**0.5

	return (AB**2 + BC**2)**0.5 == AC or (AC**2 + BC**2)**0.5 == AB or (AB**2 + AC**2)**0.5 == BC


print(estRectangle((0,0),(1,0),(0,1)))
